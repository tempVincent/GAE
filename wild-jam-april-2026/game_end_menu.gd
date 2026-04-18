extends TextureButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_pressed() -> void:
	print("button klicked")
	var err = get_tree().change_scene_to_file("res://WorkInProgress.tscn")
	print("button klicked")
	print("Scene change error: ", err)
	pass # Replace with function body.
