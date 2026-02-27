# Flashing Guide — Kinesis Advantage 360 Pro

Step-by-step instructions for flashing custom ZMK firmware to both halves.
Tested and verified February 2026.

---

## Prerequisites

- Firmware files downloaded from GitHub Actions:
  - `*-left.uf2`
  - `*-right.uf2`
- USB-C cable
- Both halves charged / power switches accessible

Current firmware lives in: `firmware-download/`

---

## Step 1: Flash the LEFT half

| Component               | State                                |
| ----------------------- | ------------------------------------ |
| Left half USB           | ✅ Plugged into your Mac              |
| Left half power switch  | Doesn't matter (powered by USB)      |
| Right half USB          | ❌ Not plugged in                     |
| Right half power switch | ✅ ON (communicates wirelessly)       |

**Action:**
1. **Hold Mod** — top-left key on the RIGHT half (the key to the left of `6`)
2. While holding, **press the left bootloader key** — the innermost key on row
   2 of the LEFT half (the key to the right of `T`). This is the physical key
   Kinesis labels "macro1"
3. The left half disconnects and remounts as a **USB drive** in Finder
4. **Drag the `*-left.uf2` file** onto the USB drive
5. The drive auto-ejects and the left half reboots

**What you should see:**
- USB drive named "ADV360PRO" (or similar) appears in Finder after step 2
- Right half LEDs may flash red (lost connection to left — normal)
- After dragging the file, the drive disappears and left half restarts

---

## Step 2: Power off BOTH halves

| Component               | Action           |
| ----------------------- | ---------------- |
| Left half USB           | **Unplug** from Mac  |
| Left half power switch  | **OFF**              |
| Right half power switch | **OFF**              |

**Wait 5 seconds.**

---

## Step 3: Power on LEFT half only

| Component               | State                                |
| ----------------------- | ------------------------------------ |
| Left half USB           | ❌ Leave unplugged                    |
| Left half power switch  | ✅ **ON**                              |
| Right half power switch | ❌ Still OFF                          |

**Wait 5 seconds** for it to fully boot. LEDs should light up.

---

## Step 4: Connect RIGHT half to USB

| Component               | State                                |
| ----------------------- | ------------------------------------ |
| Left half power switch  | ✅ ON (running on battery, no USB)    |
| Right half USB          | ✅ **Plug into your Mac**              |
| Right half power switch | ✅ **ON**                              |

**Wait a few seconds** for the right half to initialize. The two halves should
sync wirelessly (no red flashing). If still red, give it 10 seconds.

---

## Step 5: Flash the RIGHT half

**Action (use the physical reset button — the key combo is unreliable for the
right half):**
1. Flip the right half over and find the **tiny pinhole** reset button on the
   bottom of the case
2. Use a **paperclip or SIM tool** to press and hold the reset button for
   ~1 second, then release
3. The right half mounts as a **USB drive** in Finder
4. **Drag the `*-right.uf2` file** onto the USB drive
5. The drive auto-ejects and the right half reboots

**What you should see:**
- USB drive appears in Finder after pressing the reset button
- After dragging the file, the drive disappears and right half restarts

> **Note:** The Mod+macro3 key combo (hold Mod, press key left of Y)
> *should* also enter bootloader mode on the right half, but in practice it
> has been unreliable. The physical reset button is the proven method.

---

## Step 6: Reconnect normally

| Component               | State                                |
| ----------------------- | ------------------------------------ |
| Right half USB          | ✅ **Unplug**                          |
| Right half power switch | ✅ ON                                 |
| Left half USB           | ✅ **Plug back into your Mac**         |
| Left half power switch  | ✅ ON                                 |

**Wait 10 seconds** for both halves to sync wirelessly.

**What you should see:**
- Both halves' LEDs return to normal (no red flashing)
- Keyboard is responsive

---

## Step 7: Verify

Open a text editor and **hold Mod + press V**. The keyboard will type a
version string like:

```
20260226-v3.0-f031ce0-clique
```

Confirm the commit hash matches the firmware files you flashed.

---

## Quick Test for Homerow Mods

| Test          | Action                               | Expected Result              |
| ------------- | ------------------------------------ | ---------------------------- |
| Left ⌘ GUI    | Hold `A` (~⅓ sec) + tap `Space`     | Opens Spotlight (⌘+Space)    |
| Left ⇧ Shift  | Hold `F` + tap `a`                   | Types capital `A`            |
| Left ⌃ Ctrl   | Hold `D` + tap `C`                   | Copies selection (⌃+C)       |
| Left ⌥ Alt    | Hold `S` + tap `Tab`                 | App switcher (⌥+Tab)         |
| Right ⌘ GUI   | Hold `;` + tap `Space`               | Opens Spotlight (⌘+Space)    |
| Right ⇧ Shift | Hold `J` + tap `a`                   | Types capital `A`            |
| Right ⌃ Ctrl  | Hold `K` + tap `C`                   | Copies selection (⌃+C)       |
| Right ⌥ Alt   | Hold `L` + tap `Tab`                 | App switcher (⌥+Tab)         |
| 🌐 Globe      | Tap bottom-left corner key           | Opens emoji picker            |
| No misfires   | Type "sad" quickly                   | Types "sad" (no modifiers)   |

---

## Troubleshooting

**USB drive doesn't appear when entering bootloader:**
- Try the physical reset button (paperclip in the pinhole on the bottom)
- Make sure the half you're flashing is plugged in via USB
- The right half MUST be plugged in via USB to flash — it normally communicates
  wirelessly but needs a direct USB connection to mount as a drive

**Right half won't enter bootloader via key combo:**
- This is a known issue — the Mod+macro3 key combo is unreliable on the right
  half. **Use the physical reset button instead** (paperclip in the pinhole on
  the bottom of the right half). This is the recommended method.

**Red flashing LEDs:**
- This means a half lost its wireless connection to the other half
- Power cycle both halves (switches OFF, wait 5 sec, switches ON)
- This is normal during flashing — it resolves after both halves are back on

**Version string doesn't match:**
- Re-flash both halves — the left and right firmware must be from the same build
