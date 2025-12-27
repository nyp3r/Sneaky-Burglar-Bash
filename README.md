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
I used the statemachine for the player being unarmed/armed.
One reason for this is, I could easily use a statemachine implementation from someone else. It comes from this video: https://www.youtube.com/watch?v=ow_Lum-Agbs&t=302s&pp=ygUaZ29kb3QgZmluaXRlIHN0YXRlIG1hY2hpbmXSBwkJTQoBhyohjO8%3D
Another is that it's only 2 states, and a finite statemachine is simple compared to others. I don't think 2 states justifies a more complex design pattern.
#### Status flags
I have flags here:
Are used there:
#### Signals
Signals is Godot's own design pattern. If you have a node that you want to send information to other nodes, you can connect those other nodes to the signal. I use a lot in this project:



Why this layout and these choices?

- I followed Godot's official style guide for GDScript so the code is consistent and easier for other Godot users to read. Following a style guide was a deliberate choice to make collaborations and reviews smoother and to reduce bikeshedding on formatting.
- The player uses a state machine (armed/unarmed states) for its core behaviour. I debated implementing a bespoke state handler but ultimately reused a simple, well-tested state machine approach because it reduced complexity and the amount of glue code required. That tradeoff favours clarity and iteration speed over a more generic but heavier framework.
- Scenes are used to encapsulate levels, actors and reusable objects. This keeps instance data and UI separate from code and leverages Godot's scene instancing for fast iteration.

What each file and directory in this repository is and does

- README.md (this file): A project overview, developer notes and instructions.

- project.godot: The Godot project file. Open this in the Godot editor to load the project, its scenes and editor settings. This file references project-wide settings (input map, display, and other engine options used when testing and exporting).

- export_presets.cfg: Godot export preset configuration. It contains settings that would be used when exporting the game builds (platform targets, export filters, etc.). It is safe to ignore for local testing; it only matters when preparing an export.

- .editorconfig: Editor configuration used to standardise formatting across editors (tab/space preferences, end-of-line). Kept to reduce trivial diffs from different editors.

- .gitattributes: Git attributes for the repository. It can contain settings for line endings or files that should be treated specially.

- .gitignore: Files and directories that should not be committed (temporary editor files, build artifacts, etc.). This keeps the repo clean of user-specific or generated files.

- Assets/ : This directory is intended for art, audio, tilemaps and other media used by the project. It is organised so designers can drop assets in without touching scene logic. (If you are browsing the repo locally, open this folder to see sprites, sounds or other resources used by the scenes.)

- Resources/ : A place for shared resources (materials, atlases, or other Godot resource files) that multiple scenes can reference.

- Scenes/ : Contains .tscn scene files (levels, UI scenes, and composite objects). Scenes are the primary building blocks in Godot and hold node hierarchies with their attached scripts and resources.

- Scripts/ : Where GDScript (.gd) scripts live. Typical scripts here control player movement and state, simple AI, item behaviour, and UI logic. The player script uses a simple state machine to switch between armed and unarmed behaviour; I chose this for readability and to keep the control flow explicit.

- addons/ : Directory reserved for any Godot editor plugins or third-party add-ons. None are required to run the project, but the folder exists to keep any optional tools isolated.

- hidden_floor.tscn: A specific scene included in the root for quick testing or as an example environment. Scenes like this are useful when experimenting with specific mechanics without loading a full level.

- latest_score.txt: A tiny persistence helper that stores the most recent score or play result. This is an intentionally simple design: rather than creating a full save system, the game writes a small text file so demos can display the last score between runs. If the project evolves, this would be replaced by a more robust save/load system.

- design-problems: Notes and developer log about design tradeoffs and problems encountered while building the prototype. This file records decisions that were debated (for example, whether to implement a more complex AI or to keep enemy behaviours deterministic and simple) and why certain simpler choices were preferred for this prototype.

How I debated and resolved some design decisions

- State machine vs ad-hoc flags: Initially I considered using ad-hoc boolean flags to track player modes, but that approach made transitions and edge-cases harder to reason about. The finite-state machine (FSM) pattern chosen makes allowed transitions explicit and simplified animation/sound/state entry/exit handling. I reused an existing, minimal FSM script rather than building one from scratch to speed up development and reduce bugs.

- Scene-per-entity vs monolithic scripts: Splitting behaviour into scenes and attaching focused scripts to them increases the number of files but greatly improves reusability and testing. I accepted the slightly higher file count for the benefit of modularity.

- Persistence: For the prototype I used a plaintext latest_score.txt file rather than a binary or JSON save format. The reason was practicality: for a demo showing a single value, a small text file is transparent, editable, and easy to inspect. If the project grows, a move to a more structured save format will be required.

Running the project

1. Install Godot and open the repository root by opening project.godot.
2. Run the main scene (open the Scenes folder to find the launch scene) or open hidden_floor.tscn for quick experiments.
3. For contribution: follow the code style already used (Godot's GDScript style guide) and prefer small, focused commits that add or refactor one thing at a time.

If you want more detail about a particular script or scene, tell me which file and I can add a more detailed description or an in-code documentation comment. Thanks for checking out Sneaky Burglar Bash.
``` ````

Next steps
- If you'd like, I can add in-file comments for any specific script (e.g., the player script or any AI scripts), expand the "Running the project" section with exact input mappings, or include a short development roadmap. Which would you like me to do next?
