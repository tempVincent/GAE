extends Node2D

@onready var musicplayer = $BaseComponents/AudioStreamPlayer
@onready var settings= $"/root/GlobalVars"
@onready var master_bus_index = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicplayer.playing = true
	musicplayer.volume_db = 0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
