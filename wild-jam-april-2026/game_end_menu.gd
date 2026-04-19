extends TextureButton
@onready var settings= $"/root/GlobalVars"
@onready var audioStreamPlayer = $"../AudioStreamPlayer2"
signal volChanged

func _on_pressed() -> void:
	ObjectivePool.completed_obj = 0
	var newValue = ((audioStreamPlayer.volume_db+80)/104)*100
	print(newValue)
	settings.musicVol = newValue
	volChanged.emit()
	get_tree().change_scene_to_file("res://WorkInProgress.tscn")
	pass # Replace with function body.
