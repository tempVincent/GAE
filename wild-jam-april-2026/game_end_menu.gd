extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _show():
	print("Show ")
	self.visible = true

func _on_texture_button_pressed() -> void:
	print("test")
	get_tree().change_scene_to_file("res://WorkInProgress.tscn")
	#et_tree().reload_current_scene()
	pass # Replace with function body.
