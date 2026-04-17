class_name Carafe extends Tool	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn" && isBeingCarried:
		sprite.flip_h = !(get_parent().get_parent()).flip_h
