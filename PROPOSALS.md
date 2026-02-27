# Thumb Cluster & Layout Proposals

Ideas and proposals for future keymap changes. **No changes made yet** — just
documenting options to evaluate once homerow mods feel natural (2-3 weeks).

---

## Proposal 1: Thumb Cluster Rethink

### Current thumb layout
```
Left:   Backspace  Delete  |  Cmd (inner top)    Home (inner mid)
Right:  Cmd        Space   Enter  |  PgUp (inner mid)
```

### Why rethink?
With homerow mods, Cmd/Ctrl/Alt/Shift are on the home row. The dedicated Cmd
keys on the thumb cluster are now redundant. Delete, Home, and PgUp are low
frequency and don't deserve thumb positions.

### Option A: "Mac Dev Standard"
```
Left:   Backspace    Tab      Escape
Right:  Enter        Space    Layer(Nav)
```
- Tab moves to thumb (constant use: autocomplete, indent, Cmd+Tab)
- Escape moves to thumb (Vim users, dismiss dialogs, Cmd+period)
- Right thumb gets a Nav layer hold for V2 Phase 2
- Delete → move to a layer or combo (D+F = Delete?)
- Home/PgUp → move to Nav layer

### Option B: "Minimal Change"
```
Left:   Backspace    Delete    Escape
Right:  Enter        Space     Tab
```
- Keep Delete on thumb (some people use it a lot)
- Just swap in Escape and Tab for the Cmd keys
- Least disruption from current layout

### Option C: "Layer-Heavy"
```
Left:   Backspace    Layer(Sym)    Escape
Right:  Enter        Space         Layer(Nav)
```
- Both symbol and nav layers on thumb holds
- Most powerful but biggest learning curve
- This is the full Miryoku-style approach

### Recommendation
Start with **Option B** (least disruption), then graduate to **Option A** or
**Option C** once comfortable.

---

## Proposal 2: Bracket/Symbol Placement

### Current bracket locations
- `[` and `]` on bottom-right row (positions next to right Fn key)
- All other symbols on the number row (shifted)

### The problem
- Bottom-right row is a reach, especially `[`
- Shifted symbols (braces, parens, etc.) require Shift + number row = two reaches
- For a software engineer writing code, brackets/braces/parens are extremely
  high frequency

### Option A: Symbol Layer (recommended long-term)
A dedicated layer activated by a thumb hold. Right hand becomes symbols:
```
Symbol layer (right hand home block):
  Y = [    U = {    I = }    O = ]    P = |
  H = -    J = (    K = )    L = :    ; = +
  N = `    M = !    , = @    . = =    / = \
```
Left hand stays on homerow mods so Shift+symbol, Cmd+symbol all work.

### Option B: Combos for Common Pairs
Instead of a full layer, use key combos for the most common bracket types:
```
U + I  = ()    (type both parens, cursor between)
J + K  = []
K + L  = {}
```
Uses the existing macros in macros.dtsi (macro_parens, macro_brackets,
macro_braces are already defined!)

### Option C: Keep Current + Add Layer Later
Don't move brackets yet. The current positions work, they're just not optimal.
Add a symbol layer in V2 Phase 3.

### Recommendation
**Option C for now** (don't change), then add **Option A** as a layer. Consider
**Option B** combos as a quick win that can coexist with either approach.

---

## Proposal 3: Mouse Keys Layer

### What's available
The firmware now supports mouse keys via ZMK pointing:
- `&mmv MOVE_UP/DOWN/LEFT/RIGHT` — cursor movement
- `&mkp MB1/MB2/MB3` — left/right/middle click
- `&msc SCRL_UP/DOWN/LEFT/RIGHT` — scrolling

### Typical setup
A dedicated mouse layer (could share with Nav or be separate):
```
Mouse layer (right hand):
  H = Mouse Left    J = Mouse Down    K = Mouse Up    L = Mouse Right

Mouse layer (left hand):
  F = Left Click     D = Right Click    S = Middle Click
  A = still GUI mod (homerow mod passes through on &trans)

Thumb:
  Scroll Up / Scroll Down on convenient positions
```

### When to add
Low priority — macOS trackpad is usually within reach. Consider this a "nice to
have" for when you're deep in keyboard-only flow and don't want to move to the
trackpad at all. V2 Phase 5+ territory.

---

## Proposal 4: Inner Column Keys

### Current inner column (between the halves)
```
Left inner column:     Right inner column:
  tog 1 (Kp toggle)     mo 3 (Mod layer)
  none                   none
  none   Ctrl   Alt      Alt    Ctrl   none
         Home              PgUp
  Bksp   Del    Cmd      Cmd    Space  Enter
```

### The issue
With homerow mods, Ctrl and Alt on the inner columns are redundant. These 4
keys (positions 35, 36, 37, 38 in the key matrix) become free real estate.

### Ideas for inner column keys
- **Hyper key** (Ctrl+Shift+Alt+Cmd) — great for app-specific shortcuts that
  never conflict
- **Meh key** (Ctrl+Shift+Alt) — same idea, without Cmd
- **Layer toggles** — for semi-permanent layer switches
- **Media controls** — play/pause, volume (though you have these on Kp layer)
- **Copy/Paste** — one-key Cmd+C / Cmd+V
- **Screenshot** — one-key Cmd+Shift+4

### Recommendation
Low priority. Revisit after thumb cluster is settled.

---

## Proposal 5: Combos (Quick Wins)

Combos are two keys pressed simultaneously to produce a third action. These can
be added anytime without disrupting existing layout.

### Popular combos for Mac devs
```
J + K  = Escape       (right hand, no reaching to corner)
D + F  = Tab           (left hand)
F + J  = Caps Word     (both index fingers = temporary caps)
Q + W  = ` (backtick)  (useful for markdown/code)
W + E  = ~ (tilde)     (home dir, bitwise)
```

### Why combos are nice
- Zero disruption to existing layout
- Can coexist with everything else
- Easy to add/remove one at a time
- The bracket macros (macro_parens, etc.) are already defined in macros.dtsi

### Recommendation
Good V2 Phase 5 project. Low risk, easy to experiment with.

---

## Priority Order

1. ✅ Homerow mods (done — get comfortable, 2-3 weeks)
2. ✅ Globe key (done)
3. 🔜 Thumb cluster rethink (Proposal 1, after HRM is natural)
4. 🔜 Nav layer on thumb hold (V2 Roadmap Phase 2)
5. 📋 Symbol layer (Proposal 2, Option A)
6. 📋 Combos (Proposal 5)
7. 📋 Inner column optimization (Proposal 4)
8. 📋 Mouse keys layer (Proposal 3)
