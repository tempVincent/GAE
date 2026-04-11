extends RigidBody2D

var isInHand = false
var characterHand
var characterAnimation

func _enter_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		isInHand = true
		characterHand = get_parent().get_node("AnimatedSprite2D/Hand")
		characterAnimation = get_parent().get_parent()
		
		pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isInHand:
		if characterAnimation.flip_h == true:
			scale.x = -1
		else:
			scale.x = 1
