#!/bin/bash
#
# cp_right.sh — Find the mounted right half and flash the latest right firmware
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FW_DIR="$SCRIPT_DIR/firmware-download"

# Find the latest right.uf2 file
FW_FILE=$(ls -t "$FW_DIR"/*-right.uf2 2>/dev/null | head -1)

if [ -z "$FW_FILE" ]; then
    echo "❌ No *-right.uf2 file found in $FW_DIR"
    echo "   Run a GitHub Actions build and download the firmware-clique artifact first."
    exit 1
fi

echo "📦 Firmware: $(basename "$FW_FILE")"

# Look for the mounted bootloader drive
# Kinesis 360 Pro mounts as "ADV360PRO" or "Adv360Pro" or similar
MOUNT_POINT=""
for candidate in /Volumes/ADV360*/ /Volumes/Adv360*/ /Volumes/KINESIS*/ /Volumes/NRF52BOOT*/; do
    if [ -d "$candidate" ] 2>/dev/null; then
        MOUNT_POINT="$candidate"
        break
    fi
done

if [ -z "$MOUNT_POINT" ]; then
    echo "❌ No bootloader drive found."
    echo ""
    echo "   To enter bootloader mode on the RIGHT half:"
    echo "   1. Power off both halves (switches OFF), wait 5 seconds"
    echo "   2. Power on the LEFT half (switch ON, no USB), wait 5 seconds"
    echo "   3. Plug the RIGHT half into USB, switch ON"
    echo "   4. Use a PAPERCLIP on the reset pinhole on the bottom of the right half"
    echo "      (the Mod+macro3 key combo is unreliable — use the reset button)"
    echo "   5. A USB drive should appear in Finder"
    echo ""
    echo "   Waiting for drive to appear..."

    # Wait up to 30 seconds for the drive to appear
    for i in $(seq 1 30); do
        sleep 1
        for candidate in /Volumes/ADV360*/ /Volumes/Adv360*/ /Volumes/KINESIS*/ /Volumes/NRF52BOOT*/; do
            if [ -d "$candidate" ] 2>/dev/null; then
                MOUNT_POINT="$candidate"
                break 2
            fi
        done
        printf "."
    done
    echo ""

    if [ -z "$MOUNT_POINT" ]; then
        echo "❌ Timed out after 30 seconds. No bootloader drive detected."
        echo "   Make sure:"
        echo "   - The RIGHT half is plugged into USB"
        echo "   - You pressed the physical reset button (paperclip in the pinhole)"
        echo "   - The LEFT half is powered ON (battery, no USB) for wireless sync"
        exit 1
    fi
fi

echo "✅ Found bootloader drive: $MOUNT_POINT"

# Verify it looks like a valid UF2 bootloader drive
if [ ! -w "$MOUNT_POINT" ]; then
    echo "❌ Drive is not writable: $MOUNT_POINT"
    exit 1
fi

echo "⬆️  Copying $(basename "$FW_FILE") → $MOUNT_POINT"

# The cp command often returns an I/O error on macOS because the UF2 bootloader
# processes the file and ejects the drive mid-copy. This is expected and normal.
# The firmware data is fully written before the metadata operations that fail.
cp "$FW_FILE" "$MOUNT_POINT/" 2>/dev/null || true

# Wait briefly for the drive to auto-eject
echo "⏳ Waiting for drive to eject (keyboard rebooting)..."
for i in $(seq 1 10); do
    sleep 1
    if [ ! -d "$MOUNT_POINT" ]; then
        echo "✅ Right half flashed successfully! Keyboard has rebooted."
        exit 0
    fi
    printf "."
done
echo ""

# Check one more time
if [ ! -d "$MOUNT_POINT" ]; then
    echo "✅ Right half flashed successfully! Keyboard has rebooted."
    exit 0
fi

echo "⚠️  Drive hasn't ejected yet. The flash may still have worked."
echo "   Try unplugging and replugging the right half."
echo "   If the keyboard boots normally, you're good."
