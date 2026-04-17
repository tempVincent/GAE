extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum animationState {idle, idle2, walk, jump}

var animationStatePlayer: animationState
var ItemInHand: Portable
var interactionTargets: Array[Node2D]

var canMove: bool = true
var canInteract: bool = true
var handIsEmpty: bool = true

@onready var AnimationController: AnimatedSprite2D = $AnimatedSprite2D
@onready var Hand: Node2D = $AnimatedSprite2D/Hand
@onready var interactionArea: Area2D = $PlayerInteractionArea
@onready var Objects: Node2D = $"../Objects"

func _ready() -> void:
	interactionArea.area_entered.connect(func (area: Area2D) -> void:
		interactionTargets.append(area.get_parent())
		print(interactionTargets)
	)
	interactionArea.area_exited.connect(func (area: Area2D) -> void: 
		interactionTargets.erase(area.get_parent())
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
	if direction < 0 and not AnimationController.flip_h:
		AnimationController.flip_h = true
		Hand.position.x *= -1
	elif direction > 0 and AnimationController.flip_h:
		AnimationController.flip_h = false
		Hand.position.x *= -1

	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		animationStatePlayer = animationState.walk
	else:
		animationStatePlayer = animationState.idle
	
	if Input.is_action_just_pressed("ui_accept"):
		animationStatePlayer = animationState.jump

	####JUMP ANIMATION GEHT NOCH NICHT SAUBER
	if AnimationController.animation != animationState.keys()[animationStatePlayer]:
		AnimationController.play(animationState.keys()[animationStatePlayer])
		
		if animationStatePlayer == animationState.jump:
			await AnimationController.animation_finished
		
	#print(AnimationController.animation)

func interact() -> void:
	# print("interaction key pressed")
	for target in interactionTargets:
		# print("target: " + target.to_string())
		if handIsEmpty:
			# print("hand is empty")
			if target is Portable:
				# print("target is portable")
				# returns a Tool or Ingredient
				ItemInHand = target.pickupTo(Hand)
				# print(ItemInHand)
				handIsEmpty = (ItemInHand == null)
				return
			elif target is Producer:
				# print("target produces Portables")
				# returns an Ingredient
				ItemInHand = target.produce(Hand)
				handIsEmpty = (ItemInHand == null)
				return
		else:
			# print("hand is not empty")
			if target is Consumer:
				# print("target consumes Beverages")
				# consumes the Beverage and optionally returns a Tool
				ItemInHand = target.consume(ItemInHand)
				handIsEmpty = (ItemInHand == null)
				return
			elif target is Processor:
				# print("target processes Portables")
				# consumes the Ingredient or Tool and optionally returns a Beverage or Ingredient
				ItemInHand = await target.process(ItemInHand)
				handIsEmpty = (ItemInHand == null)
				return
			else:
				# print("no interaction target")
				Hand.remove_child(ItemInHand)
				Objects.add_child(ItemInHand)
				ItemInHand.global_position = Hand.global_position
				ItemInHand.global_position.y -= 150
				ItemInHand.isBeingCarried = false
				ItemInHand.freeze = false
				ItemInHand.collision.disabled = false
				ItemInHand.scale = Vector2(1,1)
				ItemInHand = null
				handIsEmpty = (ItemInHand == null)
				# print("item dropped")
				return
