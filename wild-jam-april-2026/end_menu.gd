extends Control

@onready var player = $AudioStreamPlayer2

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.playing = true
