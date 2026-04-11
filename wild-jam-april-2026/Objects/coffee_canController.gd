extends RigidBody2D

var isInHand = false
var characterHand
var characterAnimation:AnimatedSprite2D
@onready var sprite:Sprite2D = $Sprite2D
@onready var collision:CollisionPolygon2D = $CollisionPolygon2D

func _enter_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		
		##Get Resources
		
		characterHand = get_parent().get_node("AnimatedSprite2D/Hand")
		characterAnimation = get_parent().get_parent()
		
		##Set Params
		isInHand = true
		freeze = true
		position = Vector2(0,0)
		collision.disabled = true
		scale = Vector2(0.5,0.5)
		rotation = 0
		
		pass


func _exit_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		
		##Cleanup Params
		isInHand = false
		freeze = false
		collision.disabled = false
		scale = Vector2(1,1)





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isInHand:
		
		if characterAnimation.flip_h:
			sprite.flip_h= false
		else:
			sprite.flip_h= true
