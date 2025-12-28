# SNEAKY BURGLAR BASH
#### Video Demo:  https://youtu.be/n0bICfq6t18
#### Play the game: https://nyp3r.itch.io/sneaky-burglar-attack

## Description:

Sneaky Burglar Bash is a small  game made in Godot project. It's a top down stealth game, where you are getting robbed and have to sneak past the robber to get your gun and kill them.
Godot officially supports GDScript (Godot's own language), C# and C/C++. I chose GDScript, since it's made for Godot and allows for faster and easier development.

### Style
I follow the official Godot style guide. This makes it easier to get help from other Godot developers. I didn't reach out to anyone for this project, but I will continue to use Godot to develop games, so I might as well use it.

### Design patterns
#### Finite statemachine
Under Scripts/States/Utility, state.gd & state_machine.gd is code coming from this Youtube video: https://www.youtube.com/watch?v=ow_Lum-Agbs&t=302s&pp=ygUaZ29kb3QgZmluaXRlIHN0YXRlIG1hY2hpbmXSBwkJTQoBhyohjO8%3D
I used the statemachine for the player being unarmed/armed.
The files are under the folder Scripts, named unarmed.gd & armed.gd.
#### Status flags
I have flags here:
Are used there:
#### Signals
Signals is Godot's own design pattern. If you have a node that you want to send information to other nodes, you can connect those other nodes to the signal. I use a lot in this project.

All programming files are under "Scripts"
### Files
#### anti_rotation.gd
this isn't being used anymore. It used to make sure the interaction indicator for the player doesn't rotate with them.
#### armed.gd
For the armed state. It simply changes the visibility of different nodes and sets the status flag for indicating if the player has the gun in their hand.
Under physics process, it checks for if the players presses the button for switching item. If true, then set the state to unarmed.
#### bed.gd
For the bed scene. It allows the player to hide from the enemy if they are next to the bed and presses the interaction key.
#### bullet.gd
For the bullet that gets instantiated when the player shoots. It just moves the bullet each frame in the direction it's facing. When the bullet hits something, it makes sure it disconnects the bullet from the body it entered before the bullet gets destroyed (AKA freed). This is to not get an error when one is trying to access the other.
#### button.gd
It's got a bad name. It should be called play_button.gd, because it is the script for the button in the main game. It changes the music volume and changes the scene to the actual game, instead of the menu.
#### cabinet.gd
For the cabinet, which the player can hide in. It's like the bed, except it makes a sound. When the player is in range of the cabinet and presses the interaction button, it makes the sound, hides/exposes the player and hides/exposes the things that need to indicate the new state. An improvement here is that I could use a state machine for this like for the player being armed/unarmed. I decided not to access the player object, but only the game_manager (which we will get to). This is because you want to minimize where values gets changed from.
#### continue_button.gd
Changes the scene to game, which is the gameplay
#### cutscene_animation.gd
Starts the cutscene, which is a short tutorial for the game. I didn't end up using it, because I don't like tutorials in other games.
#### end_menu.gd
For the end menu. Changes scenes according to the button the player presses. I'm not sure why I open the scores.txt file. 
#### enemy.gd
For the enemy. Sets the movement speed, health, vision cone, hearing, where to walk, where to spawn at the start of the game.
##### _on_player_exposed() & _on_player_hid()
They are callback functions for the player_hid and player_exposed signals in game_manager.gd. So when the player hides somewhere, this gets called, since it's connected to the game manager. It disables/enables the vision cone raycasts, because the player doesn't really change position when they hide.
##### _on_navigation_finished()
When the enemy is just wandering around, he has to keep moving. The way he wanders, is he just picks a spot in the house and walks there. When he gets there, he needs to find somewhere else to walk to to keep wandering. So he just gets a new random position to walk to.
##### _on_bullet_hit(body)
This gets called every time the bullet hits something, so the function first checks if it did hit the enemy. If it was actually the enemy that was hit, the enemy loses 1 health. If they are then at 0 health, he dies and the player succeeded.
##### get_spacial_volume_score()
Takes the volume score from the game manager and mixes it with the distance to the player. This gives a spatial score that gets used somewhere else to check if the enemy can hear the player.
##### generate_raycasts()
Creates the vision cone for the enemy. As you can see, the vision cone is made up of raycasts. 10 To be exact
##### _physics_process(delta: float)
this function gets called a variable amount every frame.
Quite a big function. 
**Line 58 to 67** is about the enemy's footsteps. If there is a wall between the enemy and player, the sound will be set to the ones for occlusion. This is done by having a raycast from the enemy to the player. If the raycast detects anything that's of class "TileMapLayer", there is probably a wall between the two characters.
**Line 70 to 77** are about the vision cone, so this is where we check for the vision cone colliding with the player. The enemy will then react accordingly
At **line 79 to 82** we make sure the enemy runs to the escape if they saw the player with a gun, but if not they will run for the player.
**Line 84 to 91** applies movement by the navigation agent which looks at a navigation region of the house. The navigation agent uses an a* algorithm to find the best path. The enemy's body rotates according to where the next path position is. There are many path positions in a whole path.
**Line 93 to 99** gives hearing to the enemy using the function get_spacial_volume_score. If the score is over a certain number, it was loud enough for the enemy to hear it. This part also checks for if the enemy could hear a reload or shot. If he could, he has found out the enemy has a gun. A problem here is that there are magic numbers. I should've made a variable or atleast a comment describing what the numbers are.
##### start_hunt()
This sets the enemy to run. Not sure why it's sets the target position to escape position. Should maybe be called escape instead.
#### escape.gd
Checks for if the enemy has escaped by checking if the raycast is colliding with the enemy.
#### game_manager.gd
The main script, which accesses everything. Other scripts will use this to change variables of other scripts. It has the volumes scores for the enemy to hear, the interaction prompt appearing, saves the score in the scores.txt file, changes the player_is_hidden flag.
#### general_slider.gd
Sets the volume when the user has stopped dragging the slider.
#### global.gd
Script for holding the data that should be independent of what scene is used.
#### gun_drawer.gd
Script for the drawer that the player opens to get the gun. 
