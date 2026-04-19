extends TextureButton
@onready var player = $"../AudioStreamPlayer2"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.playing = true

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://WorkInProgress.tscn")
	pass # Replace with function body.
