extends Node2D

@onready var musicplayer = $BaseComponents/AudioStreamPlayer
@onready var settings= $"/root/GlobalVars"
@onready var master_bus_index = AudioServer.get_bus_index("Master")

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicplayer.playing = true
	musicplayer.volume_db = 0


func _on_explosion_sound_2_finished() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass # Replace with function body.
