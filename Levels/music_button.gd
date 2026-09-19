extends Button

@onready var musicPlayer: AudioStreamPlayer = get_tree().current_scene.get_node("bgm")

var musicON := true

func _ready() -> void: 
	pressed.connect(_on_button_pressed)
	
func _on_button_pressed() -> void:
	musicON = not musicON
	
	musicPlayer.stream_paused = not musicON
	
	if musicON:
		text = "Music: ON"
	else:
		text = "Music: OFF"
