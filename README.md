> :warning: This repository has now been superceded by the new [Outpost Assault repo](https://github.com/quiver-dev/tower-defense-tutorial) that accompanies the [Outpost Assault course](https://quiver.dev/tutorials/make-a-2d-tower-defense-game-with-godot-4/). Please use that codebase instead of this one. We're still preserving this codebase because it has one or two features not present in the other one, such as hit states. Note, however, that this version is missing explosions, sound effects, and will be less up-to-date overall.

# Outpost Assault: Tower Defense Game Template
An open source 2D tile-based tower defense game template built for Godot 4.0, created by [Quiver](https://quiver.dev).

## Prerequisites
Godot 4.0 RC 6 or later.

## Trailer
[![Outpost Assault Trailer](https://image.mux.com/48I4Lkdd7d5KKqnv00yq2mtmkj8Miel84c4NBVkUjRLU/animated.gif?start=17&end=24)](http://quiver.dev/assets/game-templates/outpost-assault-tower-defense-godot-4-template/#lg=1&slide=0)

(click to watch the full trailer!)


## Features
- Tower placement
- Different tower/weapon types
- Various projectile types
- Different enemy types
- Enemy pathfinding
- Basic enemy AI
- UI and HUD
- Player-controlled camera

## Topics covered
- Godot 4's new features:
	- GDScript's annotations
	- The massively-upgraded `TileMap` system
	- The Navigation Server API
	- Physics bodies, including the new `CharacterBody2D`
- Signals
- Class inheritance
- Scene composition (or *aggregation*)
- Character movement
- Character animation
- Collision detection
- AI implementing the Finite State Machine (FSM) pattern and states
- Following Godot's [best practices](https://docs.godotengine.org/en/latest/tutorials/best_practices/index.html)
- Creating UI and HUD using **themes** with the built-in Theme Editor
- Scene switching/reloading

## Code style and guidelines
The code will be written using static typing whenever possible and
following the official GDScript [style guide](https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_styleguide.html).

Every asset will be named using *snake_case* for usability.
`snake_case` means the first letter of each word is written in lowercase and spaces are replaced by underscores `_`.

The following convention will be used: `entity_animation_xx` where *entity* is the entity itself (e.g. _turret_, _player_, *muzzle_flash* etc.), 
*animation* refers to the type of animation and _xx_ are numbers indicating the sprite's order in the animation (starting from 00). 
Examples: `infantry_idle_00.png`, `infantry_idle_01.png`, `explosion_13.png`, `infantry_move_00.png`, etc.
Optionally, `entity` can be omitted if its sprites are in a folder named after the entity itself. 
For example, if we have tanks and infantry, we could have the following folder structure:
```
tank/idle_00.png
tank/idle_01.png
tank/move_00.png
tank/move_01.png
...
infantry/idle_00.png
...
infantry/move_00.png
...
```
`animation` can also be omitted in case an entity only has one animation (e.g. a bullet flash or an explosion).

## Installation Instructions
* This project uses [Git Large File Storage](https://git-lfs.github.com/) (LFS) to store asset binaries. To initialize it make sure you have LFS installed, then simply run ```git lfs install```
* Clone this repository from Github
* Open the project file with Godot 4 and run it to play the *Outpost Assault* demo!

## Questions/Bugs/Suggestions
For bugs and feature requests, feel free to file an issue here or comment on this template's [project page](https://quiver.dev/assets/game-templates/outpost-assault-tower-defense-godot-4-template/).

## Share with the community!
If you manage to incorporate this template into your next project, please share with the [Quiver community](https://quiver.dev/)!
