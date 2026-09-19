extends Label

@onready var player = get_tree().current_scene.get_node("Player")
@onready var highScoreLabel = get_parent().get_node("High scoer shit")

func _process(_delta: float) -> void:
	if player == null:
		return
	
	var distance := int(player.distanceScore)
	var highscore := int(player.highScoreDistance)
	
	text = "Score: " + str(distance)
	highScoreLabel.text = "High Score: " +str(highscore)
