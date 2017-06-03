# The Combine Survival Games
The Combine Survival Games is a gamemode scripted in LUA for the game Garry's Mod.

Copyright © Elimynate
<br><br>

## Overview
In this alternate timeline the Combine Forces crushed the Resistance during the events that took place in the Half-Life 2 series.

To solidify their control over the remaining human population, the Advisors established the Combine Survival Games after their decisive victory against the Resistance. Humans with approved Anticitizen status are sent to an arena weekly nearest to their city in groups of twenty-four and are forced to fight against one another.

The main event sees twenty-four citizens with approved Anticitizen status survive in an arena for as long as possible. The arena is dotted with loot containers that participants can break open in the hopes of getting something they need. The event ends when there is only one Anticitizen left alive.

## Technical
The code released here is pretty much almost bug free. The only thing that it requires is some refactoring to make it easier to change certain variables around, such as the number of end-game barriers you have in the map. However anyone with some experience in Lua can easily change these things and edit the code to their liking without any trouble.

## Map Making
The Lua code calls the following named entities from the map:


* endgame_moving_barrierx

x is any number between 1 and n where n is the number of barriers you have in the map (in tcsg_montverte it is 8)
the endgame_moving_barrierx is a func_movelinear. Attached to it is a trigger_hurt which is what damages the player.

* loot_point_tier1, loot_point_tier2, loot_point_tier3

a point on the map that spawns tier 1 loot crates. This can easily be added to by adding more tiers and adding relevant code [here](https://github.com/Elimynate/thecombinesurvivalgames-release/blob/master/gamemode/timedstagessystem/server/stages/tss_sv_stage_1.lua). Alternatively you could change the code to spawn items from a crate according to their category.

* arena_pod_barrier

the pod barriers that open upon the start of the survival games

* hatch

the hatch in tcsg_montverte is both the panel that moves the player up and the door made up of two parts that opens in the pod

* teleport_arena_pod

the teleport point that players are teleported to after the waiting phase and before the survival games phase

* teleport_victor

the teleport point the victorious player is teleported to upon winning the survival games

* teleport_waiting_area

the teleport point players are teleported to upon joining or after survival games and they are respawned

