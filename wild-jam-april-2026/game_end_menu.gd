extends TextureButton

func _on_pressed() -> void:
	ObjectivePool.completed_obj = 0
	get_tree().change_scene_to_file("res://WorkInProgress.tscn")
	pass # Replace with function body.
