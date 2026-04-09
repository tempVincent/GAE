extends CharacterBody2D


const SPEED = 400.0
const accel = 800
const JUMP_VELOCITY = -250.0
const gravity = 500
@onready var Animations = $AnimatedSprite2D
var gravity_switched = false
var gravity_dir = Vector2.DOWN


func _ready() -> void:
	Animations.play("idle")



func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("space"):
		gravity_switched = !gravity_switched
		if $AnimatedSprite2D.scale.y == -1:
			var switch:Tween = get_tree().create_tween()
			switch.tween_property($AnimatedSprite2D,"scale",Vector2(1,1),0.25).set_delay(0.1)
		else:
			var switch:Tween = get_tree().create_tween()
			switch.tween_property($AnimatedSprite2D,"scale",Vector2(1,-1),0.25).set_delay(0.1)
		
		print(gravity_switched)
	
	
	if gravity_switched == true:
		velocity -= Vector2(0,500) * delta
	else:
		velocity += Vector2(0,500) * delta

	if Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY * gravity_switched
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, accel * delta)
		Animations.play("walk")
		if direction <0:
			var switch:Tween = get_tree().create_tween()
			switch.tween_property($AnimatedSprite2D,"scale",Vector2(-1,1),0.25).set_delay(0.1)
		elif direction > 0:
			var switch:Tween = get_tree().create_tween()
			switch.tween_property($AnimatedSprite2D,"scale",Vector2(1,1),0.25).set_delay(0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, accel * delta)

	move_and_slide()
