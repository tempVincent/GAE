extends Area2D

@onready var characterAnimation = $"../AnimatedSprite2D"
@onready var character = $".."
@onready var hand = $"../AnimatedSprite2D/Hand"

func _process(delta: float) -> void:
	if characterAnimation.flip_h:
		scale.x = -1
	else:
		scale.x = 1
