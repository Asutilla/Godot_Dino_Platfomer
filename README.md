# Dino Platformer

A small 2D platformer made with **Godot 4.7**. Guide a dinosaur across floating platforms, collect mushrooms and crates, avoid patrolling porcupines, and don't fall in the water.

![Gameplay](Screenshot%202026-10-25%20015457.png)
![Game Over screen](Screenshot%202026-10-25%20015509.png)

## Features

- Tight, responsive platforming with gravity, jumping, and horizontal movement
- Animated player character (idle, running, jumping) with sprite flipping
- Patrolling enemies that turn around at fixed limits and end the run on contact
- Collectibles with a live counter in the HUD
- Kill zone below the level for falling off the map
- Game Over overlay with a Retry button, plus a Reset button to restart anytime
- Hand-built level using `TileMapLayer` and a tile atlas
- No plugins, no external dependencies — just open and run

## Controls

| Action | Keys |
| --- | --- |
| Move left | `A` / `Left Arrow` |
| Move right | `D` / `Right Arrow` |
| Jump | `W` / `Space` / `Up Arrow` |
| Reset level | `Reset` button (top right) |
| Retry after game over | `Retry` button |

## Requirements

- **Godot 4.7 or newer** (built and tested with 4.7.1, Forward+ renderer)
- Windows, Linux, or macOS

Older 4.x releases cannot open this project without upgrading it first.

## Getting Started

### Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git
cd YOUR-REPO
```

### Open in Godot

1. Launch Godot 4.7+.
2. Click **Import**, select the `project.godot` file in this folder, then **Import & Edit**.
3. Wait for the assets to import on first open.
4. Press **F5** (or the Play button) to run the game.

From the command line:

```bash
godot --path . --editor   # open the editor
godot --path .            # run the game directly
```

> The `.godot/` folder is a generated cache and is not committed. Godot recreates it automatically on first open, so the first launch takes a few seconds longer.

## Project Structure

```text
.
├── project.godot          # Project settings, input map, window config
├── main.tscn              # The level: tilemap, player, enemies, pickups, HUD
├── player.tscn / .gd      # CharacterBody2D player controller and animations
├── enemy.tscn / .gd       # Patrolling enemy (Area2D) that triggers game over
├── collectible.tscn / .gd # Pickup that increments the counter
├── kill_zone.tscn / .gd   # Fall-off-the-map trigger
├── game_over.tscn / .gd   # Game Over overlay with Retry
└── assets/
    ├── backgrounds/       # Sky/background art
    ├── characters/        # Dino idle + run frames, porcupine enemy
    ├── collectibles/      # Mushroom and crate sprites
    ├── objects/           # Bushes, trees, signs, stones, props
    └── tilesets/          # 18 terrain tiles used by the tilemap
```

### How the pieces fit together

- **`player.gd`** applies gravity when airborne, reads the `move_left` / `move_right` axes, jumps only while on the floor, and switches animations based on state. Collecting an item increments `collected` and updates the HUD label.
- **`enemy.gd`** walks back and forth between `start_x ± patrol_distance`, flipping its sprite to face the walking direction.
- **`collectible.gd`** calls `collect_item()` on any body that supports it, then frees itself.
- **`kill_zone.gd`** and **`enemy.gd`** both call `show_game_over()` on the level's `GameOver` node.
- **`game_over.gd`** pauses the player's physics/input, shows the overlay, and reloads the current scene on Retry.

## Customizing

| What | Where |
| --- | --- |
| Player speed / jump height | `player.gd` → `speed`, `jump_velocity` |
| Enemy speed / patrol range | `enemy.gd` → `speed`, `patrol_distance` |
| Window size | `project.godot` → `display/window/size` |
| Key bindings | `project.godot` → `[input]`, or **Project → Project Settings → Input Map** |
| Level layout | `main.tscn` (open in the editor and paint on the `GroundTiles` layer) |
| Pickup appearance | `collectible.tscn` → `item_texture` export on each instance |

## Credits

- Art: *TODO — add the name, author, and link of the free tileset pack used for the sprites and tiles.*
- Engine: [Godot Engine](https://godotengine.org/) (MIT License)

> Check the asset pack's license before publishing this repository publicly. If it requires attribution, put it here and in the game's credits.

## License

Code: **TODO — add your chosen license** (e.g. MIT) and include a `LICENSE` file.

Art assets are covered by their own license — see [Credits](#credits).
