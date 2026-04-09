extends Area2D

var Character:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Character = $"../CharacterBody2D"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == Character:
		gravity_direction = Vector2(0, -2)
	print(gravity_direction)
	
