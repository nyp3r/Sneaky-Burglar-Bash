extends VBoxContainer
class_name ScoreContainer

@onready var score_label0: Label = $ScoreLabel0
@onready var score_label1: Label = $ScoreLabel1
@onready var score_label2: Label = $ScoreLabel2
@onready var score_label3: Label = $ScoreLabel3
@onready var score_label4: Label = $ScoreLabel4

func _ready() -> void:
	load_scores()

func load_scores():
	var score_labels: Array[Label] = [score_label0, score_label1, score_label2, score_label3, score_label4]
	var latest_score_file = FileAccess.open("user://latest_score.txt", FileAccess.READ)
	var latest_score := latest_score_file.get_float()
	var save_file = FileAccess.open("user://scores.txt", FileAccess.READ)
	
	var scores: Array
	while !save_file.eof_reached():
		scores.append(save_file.get_float())
	scores.sort()
	
	if scores.size() > 1: 
		scores.remove_at(0)
		
		for j in range(score_labels.size()):
			if j == scores.size():
				break
			score_labels[j].text = str("%0.2f" % scores[j], "s")
			if latest_score == scores[j]:
				score_labels[j].add_theme_color_override("Font Color", Color.RED)
	else:
		for label in score_labels:
			label.text = "-"
	
	save_file.close()


func _on_clear_scores_button_pressed() -> void:
	var scores_file = FileAccess.open("res://scores.txt", FileAccess.WRITE)
	var latest_score_file = FileAccess.open("res://latest_score.txt", FileAccess.WRITE)
	scores_file.resize(0)
	latest_score_file.resize(0)
	load_scores()
