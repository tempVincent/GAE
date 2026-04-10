extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum animationState {idle, idle2, walk, jump}
var animationStatePlayer: animationState
@onready var AnimationController =  $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	animation(direction)
	
	
	
	move_and_slide()


func animation(direction) -> void:
	if direction < 0:
		AnimationController.flip_h = true
	else:
		AnimationController.flip_h = false

	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		animationStatePlayer= animationState.walk
	else:
		animationStatePlayer= animationState.idle
	
	if Input.is_action_just_pressed("ui_accept"):
		animationStatePlayer= animationState.jump
	
	
	
	####JUMP ANIMATION GEHT NOCH NICHT SAUBER
	if AnimationController.animation != animationState.keys()[animationStatePlayer]:
		AnimationController.play(animationState.keys()[animationStatePlayer])
		
		if animationStatePlayer == animationState.jump:
			await AnimationController.animation_finished
		
	print(AnimationController.animation)
