extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum animationState {idle, idle2, walk, jump}
var animationStatePlayer: animationState
var itemInHand: Node2D
@onready var AnimationController =  $AnimatedSprite2D
@onready var Hand = $AnimatedSprite2D/Hand
@onready var InteractiveArea = $Area2D
signal interactSignal
var canMove = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if canMove:
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
		
		interact()
		
		animation(direction)
		
		
		move_and_slide()


func animation(direction) -> void:
	if direction < 0 and AnimationController.flip_h != true:
		AnimationController.flip_h = true
		Hand.position.x *= -1
	elif direction >0 and AnimationController.flip_h != false:
		AnimationController.flip_h = false
		Hand.position.x *= -1

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
		
	#print(AnimationController.animation)


func interact() -> void:
	if Input.is_action_just_pressed("interact"):
		interactSignal.emit()
	
	
	pass
