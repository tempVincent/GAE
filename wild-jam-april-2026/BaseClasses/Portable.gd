class_name Portable extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

var isBeingCarried: bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isBeingCarried && get_parent().get_parent().get_parent().scene_file_path == "res://player/silvester.tscn":
		sprite.flip_h = !(get_parent().get_parent()).flip_h

func pickupTo(carrier: Node2D) -> Portable:
	get_parent().remove_child(self)
	carrier.add_child(self)
	global_position = carrier.global_position
	isBeingCarried = true
	freeze = true
	return self
