class_name Carryable extends RigidBody2D

var data: Resource = null
var characterAnimation: AnimatedSprite2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

func getData() -> Resource:
	return data

func directionChangeAnimation(parentAnim: AnimatedSprite2D) -> void:
	sprite.flip_h = !parentAnim.flip_h
