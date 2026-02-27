#!/bin/bash
#
# cp_left.sh — Find the mounted left half and flash the latest left firmware
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FW_DIR="$SCRIPT_DIR/firmware-download"

# Find the latest left.uf2 file
FW_FILE=$(ls -t "$FW_DIR"/*-left.uf2 2>/dev/null | head -1)

if [ -z "$FW_FILE" ]; then
    echo "❌ No *-left.uf2 file found in $FW_DIR"
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
    echo "   To enter bootloader mode on the LEFT half:"
    echo "   1. Plug the LEFT half into USB"
    echo "   2. Make sure the RIGHT half is ON (power switch)"
    echo "   3. Hold Mod (top-left key, right half) + press the key right of T (left half)"
    echo "   4. A USB drive should appear in Finder"
    echo "   5. If not, use a paperclip on the reset pinhole on the bottom of the left half"
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
        echo "   Check that the left half is in bootloader mode and connected via USB."
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
        echo "✅ Left half flashed successfully! Keyboard has rebooted."
        exit 0
    fi
    printf "."
done
echo ""

# Check one more time
if [ ! -d "$MOUNT_POINT" ]; then
    echo "✅ Left half flashed successfully! Keyboard has rebooted."
    exit 0
fi

echo "⚠️  Drive hasn't ejected yet. The flash may still have worked."
echo "   Try unplugging and replugging the left half."
echo "   If the keyboard boots normally, you're good."
