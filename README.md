# Universal Kill Streaks and PowerUp Rewards

This add-on gives **Doom** and **Doom II**-style games **kill streak shout-outs**, a **bonus pickup every five kills**, and a bunch of **extra power-up orbs** you can turn on or off. It is built to work with **vanilla** play or alongside other gameplay mods.

![Kill streak globe](https://github.com/user-attachments/assets/70a95829-a7f3-4fc4-a8f8-1f9c06d95445)

---

## What you get

1. **Gold globe — “turn streaks on”**  
   Pick up the small gold globe once. After that, the mod tracks your streak for that run and can show messages and play the announcer.

2. **Milestones**  
   At certain kill counts you can get on-screen text, optional **big titles**, and voice lines in the spirit of **Unreal Tournament**.

3. **Every five kills — one random gift**  
   On kill 5, 10, 15, and so on, you get **one** random reward from the list you left enabled in the menu. If you turn **everything** off for that list, you simply get no extra item that time — the game keeps running.

4. **More orbs in maps (optional)**  
   A separate set of switches controls which **new** orb pickups this mod is allowed to place in levels. That is **not** the same list as the five-kill gift; you can mix and match.

---

## Quick start

1. Load this mod **after** your main game data (WAD), using **GZDoom 4.10 or newer** or **UZDoom 4.10 or newer**.
2. Start a map and pick up the **gold globe** once.
3. Open **Options → Universal Kill Streaks & PowerUp Rewards** and tweak voice, text, gifts, and map drops to taste.
4. Play: milestones fire when they should, and **every fifth kill** rolls one random enabled gift.

---

## Features in one place

- Kill streak on/off, rare gold globe spawns, and a queue for streak messages and big titles  
- Five-kill **random reward** (re-uses the map spots that normally hold the **blue MegaArmor** sphere in many Doom II maps — see *Playing with other mods* below)  
- Short boosts: haste, double damage, invulnerability, infinite ammo, coffee speed-up, slow-motion time sphere  
- Extra orbs: guard, crucifix, regen, deflection, lifeshield, electric aura, “can’t die below 1 HP” legend sphere  
- **Realm667-style** extra rewards in the five-kill pool (boots, bracers, book, fire/frost auras, flight, wraith hand, lich skull, pentacle, reflector)  
- **Classic** familiar summon and optional **drone** familiar summon  
- Voice pack for streak lines; light **power-up tint** on these pickups (`Powerup.Color` blend alpha **0.002** where a tint is defined)  
- A soft gold glow on the streak globe  

---

## Playing with other mods

- **Engine:** GZDoom or UZDoom **4.10 or newer**.  
- **Games:** Tuned for **Doom / Doom II**. Other games in the family may work, but sounds and some pickups are built with Doom in mind — try your setup and see.  
- **MegaArmor spots:** The five-kill gift uses the **MegaArmor** pickup slot in many maps. If another mod also changes that same pickup, pick **one** mod to “own” it or change load order until you are happy.  
- **Multiplayer:** Host-controlled switches affect which gifts and map drops exist for everyone; some choices (announcer, big text) are **per player** in the menu.

---

## Menu guide (Options → Universal Kill Streaks & PowerUp Rewards)

**Main page**

| What you see | Plain meaning |
|----------------|----------------|
| Enable kill streak system | Whole feature on or off. |
| Chance to spawn kill-streak globe on kill | How often a gold globe might appear when you kill something (0–100%). |
| Show big on-screen title + subtitle at milestones | Huge celebratory text for big moments. |
| Random kill can spawn one globe per map | Caps the rare globe to **one per map** so it does not flood the level. |
| Announcer voice | Voice lines on or off. |
| Announcer volume | How loud the voice is. |
| Enable kill streak HUD message queue | Lets smaller messages and big-font lines run in order instead of fighting each other. |

**Submenu — Power-up pool (five-kill random reward)**  
Each line is **one possible gift** on kill 5, 10, 15, … Turn off what you do not want in the random bag. If every line here is off, that roll gives **nothing**.

**Submenu — Power-up spawn settings (random map drops)**  
These only affect **extra orbs appearing in the level as normal pickups**, not the five-kill roll.

---

## Credits

- **Put together by:** RENEGADE ANDROiD  
- **Kill streak idea and flow:** grew out of the **Project Brutality War Pack** / **Pandemonium Shoo Krew** style of streak play.  
- **Power-up orbs and helpers:** **Unless You Got Powah!**–style set and behavior.  
- **Announcer lines:** **Unreal Tournament**–style voice pack (shipped with the mod as audio files).  
- **Optional drone familiar:** inspired by the **Project Brutality 2022** streak drone, but uses its **own** names here so it can sit next to the classic familiar.  
- **Realm667-style reward pack:** folded from **Project Brutality 2022**’s Realm667 power-up definitions; **sprite and `.ogg` lumps** for that pack live in `SPRITES/ITEMS/Powerups/Realm667/` and `sounds/Realm667Powerups/` (synced from PB’s `SPRITES/.../Realm667` and `SOUNDS/Realm667Powerups/`). Per-item author credits are in the headers of `actors/Items/Realm667Powerups/Realm667Powerups.dec` and `zscript/PowerUps/Realm667Powerups.zs` (including DeVloek, Ghastly_dragon, Captain Toenail, zrrion the insect, MagicWazard, scalliano / RichardDS90, NeuralStunner, Cryomundus, and others named there).

If you reuse or remix this work, keep these credits easy to find in your project.
