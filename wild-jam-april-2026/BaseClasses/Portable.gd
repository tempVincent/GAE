class_name Portable extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

var isBeingCarried: bool

func pickupTo(carrier: Node2D) -> Portable:
	get_parent().remove_child(self)
	carrier.add_child(self)
	global_position = carrier.global_position
	isBeingCarried = true
	freeze = true
	return self
