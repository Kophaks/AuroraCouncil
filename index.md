## Download
Download the latest AuroraCouncil version here: 

<span class="downloads"><a href="https://github.com/Mithnar/AuroraCouncil/archive/v0.3.zip">AuroraCouncil 0.3</a></span>

## Description

Loot overview and distribution addon for 1.12.1 World of Warcraft.

This Addon is in an early stage, there might be breaking bugs. If you feel like the addon broke in some way, it can be reset by the loot master by entering "/ac reset" into the in-game chat.

## Installation

1. Close World of Warcraft.
2. Extract the "AuroraCouncil" directory into "...\World of Warcraft\Interface\AddOns\".
3. Activate AuroraCouncil in the character selection screen under "Addons".

## Usage

The Addon will activate itself when you're in a Group/Raid with masterloot activated.

#### General Flow:
1. Loot master is looting a corpse.
2. If there is loot that can be distributed via master loot, the loot distribution will start.
3. Loot master clicks on an item to distribute, a window with loot options (need, greed etc...) will appear for everyone.
4. After selecting a loot option by clicking on it, you will see a list of players along with their decision.
5. The loot master can now select a player in the list to distribute the loot to.
6. Click "Yes" to confirm the loot assignment.
7. Steps 2 - 6 repeat until there is no assignable loot left.

#### Chat Commands:
* /ac enable -> enables/disables the addon ( only for loot master).
* /ac reset -> resets the addon to the default state.
* /ac options -> Sets the loot options.
  * Format: /ac options Option1;Option2;Option3;Option4;Option5;Option6
  * Options can be hidden in the overview by adding ~ at the front: /ac options BiS;Need;Offspec;~Pass
  * You will always see yourself, even when the option is hidden in the overview.

## Screenshots
##### Loot master frame
![Alt text](readme/lootmasterframe.png)
 
##### Loot options frame
![Alt text](readme/lootoptionsframe.png)
 
##### Loot overview frame
![Alt text](readme/overviewframe.png)

## Questions? Issues? Contributions?
If you have any questions, issues or want to contribute to the project, feel free to join the AuroraCouncil Discord:
https://discord.gg/qU9A5xm

