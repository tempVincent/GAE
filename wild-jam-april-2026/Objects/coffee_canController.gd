extends RigidBody2D

var isInHand = false
var characterHand

func _enter_tree() -> void:
	print("sssssss")
	if get_parent().scene_file_path == "res://Player/silvester.tscn":
		isInHand = true
		characterHand = get_parent().get_node("AnimatedSprite2D/Hand")
		
		pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isInHand:
		if characterHand.flip_h == true:
			scale.x = -1
		else:
			scale.x = 1
