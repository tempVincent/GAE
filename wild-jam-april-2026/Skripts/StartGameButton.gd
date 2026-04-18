extends Button
var tween:Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up() -> void:
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self,"theme_override_font_sizes/font_size",20,0.5)
	tween.kill()
	
	get_tree().change_scene_to_file("res://WorkInProgress.tscn")
	
	pass # Replace with function body.


func _on_button_down() -> void:
	tween = get_tree().create_tween()
	
	tween.set_loops()
	tween.tween_property(self,"theme_override_font_sizes/font_size",5,0.25)
	tween.tween_property(self,"theme_override_font_sizes/font_size",20,0.5)
	pass # Replace with function body.
