# V2 Optimization Roadmap

Once you're comfortable with homerow mods (give it 2-3 weeks), consider these
upgrades roughly in this order. Each one is independent — cherry-pick what
appeals to you.

---

## Phase 1: Thumb Cluster Rethink (~week 3-4)

### Why
With homerow mods handling Ctrl/Alt/Shift/GUI, the dedicated modifier keys on
the thumb cluster and bottom row become redundant. Those are now prime real
estate for layer access and high-frequency keys.

### What to change
Your current thumb cluster (left→right):

```
Left:   Backspace  Delete  Cmd    (inner column: Home above)
Right:  Cmd        Space   Enter  (inner column: PgUp above)
```

Recommended v2 thumb layout:

```
Left:   Backspace  Delete  Escape    (or: Bksp  Tab  Escape)
Right:  Enter      Space   Tab       (or: Enter Space -)
```

### What to reclaim
- **Bottom-left row key 3** is currently `&kp LCTRL` (your no-caps-lock
  change). With homerow mods, D already gives you Ctrl on hold. Consider
  putting something more useful here: `&kp LCMD`, a layer tap, or `&none`.
- **The physical Ctrl/Alt keys** in the inner thumb columns (positions 35/36
  and 37/38) — these are now free since GACS lives on the home row. Great
  spots for `&mo <layer>` or one-shot modifiers.

---

## Phase 2: Navigation Layer via Thumb Hold (~week 4-5)

### Why
Vim-style navigation without leaving the home row. This is the single biggest
productivity unlock after homerow mods.

### How
Add a `nav` layer activated by holding a thumb key (e.g., right thumb Space
becomes `&lt NAV SPACE` — tap for Space, hold for Nav layer):

```
Nav layer (right hand):
  H = Left
  J = Down
  K = Up
  L = Right
  U = Home
  I = End
  Y = PgUp
  N = PgDn
```

Left hand stays on homerow mods while Nav is active, so you get Cmd+Arrow,
Shift+Arrow, etc. for free — text selection without touching a mouse.

---

## Phase 3: Symbol Layer (~week 5-6)

### Why
Reaching for the number row and shifted symbols breaks hand position. A
dedicated symbol layer on a thumb hold brings them all to the home block.

### Example (Miryoku-style)
Activate with left thumb hold. Right hand becomes:

```
  {  &  *  (  }
  :  $  %  ^  +
  ~  !  @  #  |
         (  )  _
```

Left hand stays on homerow mods so `Shift+symbol` still works.

---

## Phase 4: Number Layer (~week 5-6)

### Why
Same idea as symbols — a numpad on the right hand or a number row on the home
row means you never reach up.

### Example
Right hand home row: 1 2 3 4 5 / 6 7 8 9 0 arranged however you prefer
(numpad cluster or linear). Pair with homerow mods on the left for things like
Cmd+1 (switch tabs).

---

## Phase 5: Combos (~week 6+)

### What
ZMK combos let you press two keys simultaneously to produce a third. Useful for
keys that don't deserve a dedicated spot but you use often.

### Popular combos
- **J+K** → Escape (right hand, no reaching)
- **D+F** → Tab (left hand)
- **F+J** → Caps Word (temporary caps that auto-disables after one word)
- **Q+W** → `` ` `` (backtick)

---

## Phase 6: Caps Word & Sticky Keys (~week 6+)

### Caps Word
`&caps_word` — turns on Caps Lock but automatically turns it off when you press
Space, Enter, or any non-alpha key. Perfect for typing `SCREAMING_SNAKE_CASE`
constants. Much better than Caps Lock.

### Sticky Keys (One-Shot Modifiers)
`&sk LSHFT` — press and release Shift, the *next* keypress will be shifted.
No holding required. Useful if you find homerow mod holds awkward for single
capital letters. Can coexist with homerow mods — put them on a layer or combo.

---

## Timing Tuning Reference

If you're getting misfires or missed holds, these are the three knobs:

| Parameter              | Current | Faster typist | Slower/deliberate |
|------------------------|---------|---------------|-------------------|
| `tapping-term-ms`      | 280     | 200-250       | 300-350           |
| `quick-tap-ms`         | 175     | 125-150       | 175-200           |
| `require-prior-idle-ms`| 150     | 100-125       | 175-200           |

- **Getting accidental holds** (typing "the" → Ctrl+E)? Raise
  `require-prior-idle-ms` or lower `tapping-term-ms`.
- **Can't trigger holds fast enough?** Lower `tapping-term-ms`.
- **Double-tapping a homerow key doesn't repeat?** Lower `quick-tap-ms`.

---

## Blank Keycap Tips

Going blank is great for forcing muscle memory. A few suggestions:

1. **Homing bumps matter more than ever** — make sure your F and J caps have
   them (or add bump stickers). They're your entire reference point.
2. **Consider keeping legends on thumb keys** for the first month — those are
   the hardest to memorize since they're not touch-typed.
3. **Print a cheat sheet** and tape it to your monitor, not your keyboard.
   You want to train your fingers, not your eyes.
4. **Use a typing trainer** like keybr.com or monkeytype.com — 10 min/day
   accelerates adaptation significantly.
