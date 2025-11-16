extends VBoxContainer

@onready var highscore_label: Label = $HighscoreNumberLabel
@onready var score_label1: Label = $ScoreLabel1
@onready var score_label2: Label = $ScoreLabel2
@onready var score_label3: Label = $ScoreLabel3
@onready var score_label4: Label = $ScoreLabel4

func _ready() -> void:
	var save_file = FileAccess.open("res://save_file.txt", FileAccess.READ)
	
	highscore_label.text = str("%0.2f" % save_file.get_float(), "s")
	score_label1.text = str("%0.2f" % save_file.get_float(), "s")
	score_label2.text = str("%0.2f" % save_file.get_float(), "s")
	score_label3.text = str("%0.2f" % save_file.get_float(), "s")
	score_label4.text = str("%0.2f" % save_file.get_float(), "s")
	
	save_file.close()
