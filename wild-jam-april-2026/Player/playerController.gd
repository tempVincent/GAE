class_name PlayerController extends CharacterBody2D

enum animationState {idle, idle2, walk, jump}
signal interactSignal
signal directionChangeSignal
const JUMP_VELOCITY = -400.0
const step_sound = [preload("res://soundFX/footstep07.ogg"),preload("res://soundFX/footstep08.ogg"),preload("res://soundFX/footstep09.ogg"), preload("res://soundFX/footstep00.ogg")]
var SPEED = 400.0
var animationStatePlayer: animationState
var itemInHand: Node2D
var canMove = true

@onready var AnimationController =  $AnimatedSprite2D
@onready var Hand = $AnimatedSprite2D/Hand
@onready var InteractiveArea = $Area2D
@onready var foot_sound: AudioStreamPlayer2D = $AnimatedSprite2D/FootSound

## 
func _ready() -> void:
	directionChangeSignal.connect(animation)
	if foot_sound.stream == null:
		foot_sound.stream = step_sound.pick_random()

## 
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if canMove:
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("run"):
			SPEED = 550
		if Input.is_action_just_released("run"):
			SPEED = 400
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("interact"):
			interactSignal.emit()
		
		directionChangeSignal.emit(direction)
		move_and_slide()

## 
func _play_footstep():
	print("Setting audio stream")
	foot_sound.stream = step_sound.pick_random()
	print("Current stream: " + str(foot_sound.stream))
	foot_sound.play()

## 
func animation(direction) -> void:
	if direction < 0 and !AnimationController.flip_h:
		AnimationController.flip_h = !AnimationController.flip_h
		Hand.position.x *= -1
		InteractiveArea.collisionShape.position.x *= -1
	elif direction > 0 and AnimationController.flip_h:
		AnimationController.flip_h = !AnimationController.flip_h
		Hand.position.x *= -1
		InteractiveArea.collisionShape.position.x *= -1
	
	if itemInHand != null:
		itemInHand.directionChangeAnimation(AnimationController)
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		animationStatePlayer = animationState.walk
		if is_on_floor() and !foot_sound.playing:
			foot_sound.play()
	else:
		foot_sound.stop()
		animationStatePlayer = animationState.idle
	
	if Input.is_action_just_pressed("ui_accept"):
		animationStatePlayer = animationState.jump
	
	####JUMP ANIMATION GEHT NOCH NICHT SAUBER
	if AnimationController.animation != animationState.keys()[animationStatePlayer]:
		AnimationController.play(animationState.keys()[animationStatePlayer])
		
		if animationStatePlayer == animationState.jump:
			await AnimationController.animation_finished

## returns the item currently parented to the player's hand or null if there isn't one
func getItemInHand() -> Node2D:
	return InteractiveArea.hand.get_child(0)

## places an item in the player's hand. Also takes null. Doesn't replace an existing item.
func placeIteminHand(item: Node2D) -> void:
	printerr("NOT IMPLEMENTED")

## 
func _on_animated_sprite_2d_sprite_frames_changed() -> void:
		if $AnimatedSprite2D.animation == "walk":
			var frame = $AnimatedSprite2D.frame
			if frame == 2 or frame == 4:
				_play_footstep()
