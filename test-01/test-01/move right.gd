extends CharacterBody2D

var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2(1,0)
	direction = direction.normalized()
	velocity = direction * speed

	move_and_slide()
	pass
