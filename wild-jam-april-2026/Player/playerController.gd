extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum animationState {idle, idle2, walk, jump}

var animationStatePlayer: animationState
var ItemInHand: Carryable
var interactionTargets: Array[Area2D]

var canMove: bool = true
var canInteract: bool = true
var handIsEmpty: bool = true

@onready var AnimationController: AnimatedSprite2D = $AnimatedSprite2D
@onready var Hand: Node2D = $AnimatedSprite2D/Hand
@onready var interactionArea: Area2D = $PlayerInteractionArea

func _init() -> void:
	pass

func _ready() -> void:
	interactionArea.area_entered.connect(func (area: Area2D) -> void:
		interactionTargets.append(area)
	)
	interactionArea.area_exited.connect(func (area: Area2D) -> void: 
		interactionTargets.erase(area)
	)

func _process(delta: float) -> void:
	# Handle interaction
	if canInteract:
		if Input.is_action_just_pressed("interact"):
			interact()

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if canMove:
		# Get the input direction and handle the movement/deceleration
		# As good practice, you should replace UI actions with custom gameplay actions
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Handle jump
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		animation(direction)
		
		move_and_slide()

func animation(direction) -> void:
	if direction < 0 and AnimationController.flip_h != true:
		AnimationController.flip_h = true
		Hand.position.x *= -1
	elif direction > 0 and AnimationController.flip_h != false:
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
	print("interaction key pressed")
	for target in interactionTargets:
		if handIsEmpty:
			print("hand is empty")
			if target.is_class("Carryable"):
				print("target is carryable")
				# pickup returns the Carryable produced by the interaction target
				ItemInHand = target.get_parent().pickupTo(Hand)
			elif target.is_class("Producer"):
				print("target produces Carryables")
				# pickup returns the Carryable produced by the interaction target
				ItemInHand = target.receiveTo(Hand)
		else:
			print("hand contains " + Hand.get_children()[0].to_string())
			if target.is_class("Processor"):
				print("target processes Carryables")
				# process consumes the ItemInHand and optionally returns a Carryable
				ItemInHand = target.process(ItemInHand)
			else:
				print("no interaction occurred")
	handIsEmpty = (ItemInHand == null)
