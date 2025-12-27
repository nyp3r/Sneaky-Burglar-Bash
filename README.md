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
this is the armed state. It simply changes the visibility of different nodes and sets the status flag for indicating if the player has the gun in their hand.
Under physics process, it checks for if the players presses the button for switching item. If true, then set the state to unarmed.
#### bed.gd
this is the script for the bed scene. It allows the player to hide from the enemy if they are next to the bed and presses the interaction key.
#### bullet.gd
This is for the bullet that gets instantiated when the player shoots. It just moves the bullet each frame in the direction it's facing. When the bullet hits something, it makes sure it disconnects the bullet from the body it entered before the bullet gets destroyed (AKA freed). This is to not get an error when one is trying to access the other.
#### button.gd
It's got a bad name. It should be called play_button.gd, because it is the script for the button in the main game. It changes the music volume and changes the scene to the actual game, instead of the menu.
#### cabinet.gd
The script for the cabinet, which the player can hide in. It's like the bed, except it makes a sound.
