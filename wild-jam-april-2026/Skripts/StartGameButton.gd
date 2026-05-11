extends Button

var tween:Tween

## overrides base class listener
func _on_button_up() -> void:
#	tween.kill()
#	tween = get_tree().create_tween()
#	tween.tween_property(self,"theme_override_font_sizes/font_size",20,0.5)
#	tween.kill()
	get_tree().change_scene_to_file("res://WorkInProgress.tscn")

## overrides base class listener
func _on_button_down() -> void:
	#tween = get_tree().create_tween()
	pass
	#tween.set_loops()
	#tween.tween_property(self,"theme_override_font_sizes/font_size",5,0.25)
	#tween.tween_property(self,"theme_override_font_sizes/font_size",20,0.5)
