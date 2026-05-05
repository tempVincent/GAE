class_name Fruit extends RigidBody2D

var sprite: Sprite2D
var defaultTexture: CompressedTexture2D = preload("res://assets/fruits/Banane.png")
var peelTexture: CompressedTexture2D = load("res://assets/fruits/Chilli.png")
var isInHand = false
var isHazard = false
#var characterHand
var characterAnimation: AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D
var data: Resource = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = get_node("Sprite2D")
	sprite.texture = defaultTexture
	var transitionIN:Tween = get_tree().create_tween()
	transitionIN.tween_property(self,"scale",Vector2(1,1),0.5)
	await transitionIN.finished
	transitionIN.kill()
	self.gravity_scale = 1
	
func getData() -> Resource:
	return data

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
