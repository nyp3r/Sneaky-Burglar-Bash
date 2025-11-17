extends VBoxContainer
class_name ScoreContainer

@onready var highscore_label: Label = $HighscoreNumberLabel
@onready var score_label1: Label = $ScoreLabel1
@onready var score_label2: Label = $ScoreLabel2
@onready var score_label3: Label = $ScoreLabel3
@onready var score_label4: Label = $ScoreLabel4
@onready var highscore_indicator_label: Label = $"../HighscoreIndicatorLabel"

func _ready() -> void:
	load_scores()

func load_scores():
	var score_labels = [highscore_label, score_label1, score_label2, score_label3, score_label4]
	var latest_score_file = FileAccess.open("res://latest_score.txt", FileAccess.READ)
	var latest_score := latest_score_file.get_float()
	var save_file = FileAccess.open("res://scores.txt", FileAccess.READ)
	
	var scores: Array
	var i := 0
	while !save_file.eof_reached():
		scores.append(save_file.get_float())
		print(scores[i])
		i += 1
	scores.sort()
	
	if scores.size() > 1: 
		scores.remove_at(0)
		if latest_score == scores[0]:
			highscore_indicator_label.visible = true
		else:
			highscore_indicator_label.visible = false
		
		for j in range(score_labels.size()):
			if j == scores.size():
				break
			score_labels[j].text = str("%0.2f" % scores[j], "s")
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
