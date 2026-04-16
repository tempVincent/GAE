extends Carryable	

var characterAnimation: AnimatedSprite2D
var content: Ingredient

func _enter_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		##Get Resources
		characterAnimation = get_parent().get_parent()
		
		##Set Params
		freeze = true
		position = Vector2(0,0)
		collision.disabled = true
		scale = Vector2(0.5,0.5)
		rotation = 0

func _exit_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		##Cleanup Params
		freeze = false
		collision.disabled = false
		scale = Vector2(1,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn" && isBeingCarried:
		sprite.flip_h = !characterAnimation.flip_h
