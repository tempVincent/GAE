class_name Fruit extends RigidBody2D

var sprite: Sprite2D
var area: Area2D
var defaultTexture: CompressedTexture2D = preload("res://Assets/fruits/Banane.png")
var peelTexture: CompressedTexture2D = preload("res://Assets/fruits/Chilli.png")
var isInHand = false
var characterHand
var characterAnimation:AnimatedSprite2D
@onready var collision:CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = get_node("Sprite2D")
	area = get_node("Area2D")
	sprite.texture = defaultTexture
	area.area_entered.connect(becomeHazard)

func becomeHazard(a: Area2D) -> void:
		print("fruit hit floor2")
		get_parent().remove_child(self)
		freeze = true
		linear_velocity = Vector2(0, 0)
		scale = Vector2(2, 2)
		sprite.texture = peelTexture
		set_collision_layer_value(13, true)
		set_collision_layer_value(9, false)
		set_collision_mask_value(9, false)

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

func _exit_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		
		##Cleanup Params
		isInHand = false
		freeze = false
		collision.disabled = false
		scale = Vector2(1,1)
