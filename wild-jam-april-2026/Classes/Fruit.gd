class_name Fruit extends RigidBody2D

var sprite: Sprite2D
var defaultTexture: CompressedTexture2D = preload("res://assets/fruits/Banane.png")
var peelTexture: CompressedTexture2D = load("res://assets/fruits/Chilli.png")
var isInHand = false
var isHazard = false
#var characterHand
var characterAnimation: AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = get_node("Sprite2D")
	sprite.texture = defaultTexture
	#get_node("Area2D").area_entered.connect(becomeHazard.bind())

func becomeHazard(a: Area2D) -> void:
	print("collided with floor2")
	freeze = true
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	global_position.y = 160
	sprite.texture = peelTexture # texture doesn't change for some reason
	set_collision_layer_value(13, true)
	set_collision_layer_value(9, false)
	set_collision_mask_value(9, false)
	remove_from_group("pickable")

func _enter_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		
		##Get Resources
#		characterHand = get_parent().get_node("AnimatedSprite2D/Hand")
		characterAnimation = get_parent().get_parent()
		
		##Set Params
		isInHand = true
		freeze = true
		position = Vector2(0,0)
		collision.disabled = true
		scale = Vector2(0.5,0.5)
		rotation = 0

func _exit_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		
		##Cleanup Params
		isInHand = false
		freeze = false
		collision.disabled = false
		scale = Vector2(1,1)
