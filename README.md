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
Signals is Godot's own design pattern. If you have a node that you want to send information to other nodes, you can connect those other nodes to the signal. I use a lot in this project:
