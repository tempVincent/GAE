extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var Animations = $AnimatedSprite2D


func _ready() -> void:
	Animations.play("idle")



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		Animations.play("walk")
		if direction <0:
			Tween switch = Tween.new()
			switch.
			Animations.flip_h = true
		elif direction > 0:
			Animations.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
