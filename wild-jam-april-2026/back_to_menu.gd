extends TextureButton

## override base class listener when the button is pressed
func _on_pressed() -> void:
	ObjectivePool.completed_obj = 0
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	 # Replace with function body.
