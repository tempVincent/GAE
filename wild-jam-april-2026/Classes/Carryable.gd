class_name Carryable extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

var isBeingCarried: bool

func pickupTo(carrier: Node2D) -> Carryable:
	get_parent().remove_child(self)
	carrier.add_child(self)
	isBeingCarried = true
	return self
