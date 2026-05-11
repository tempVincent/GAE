class_name Coffee_canController extends Carryable

var item_type = "coffee_can"

func _enter_tree() -> void:
	var playerMaybe = get_parent().get_parent().get_parent()
	if playerMaybe.scene_file_path == "res://Player/silvester.tscn":
		
		##Get Resources
		characterAnimation = get_parent().get_parent()
		
		##Set Params
		freeze = true
		position = Vector2(0,0)
		collision.disabled = true
		scale = Vector2(0.5,0.5)
		rotation = 0

func _exit_tree() -> void:
	var playerMaybe = get_parent().get_parent().get_parent()
	if playerMaybe.scene_file_path == "res://Player/silvester.tscn":
		
		##Cleanup Params
		freeze = false
		collision.disabled = false
		scale = Vector2(1,1)
