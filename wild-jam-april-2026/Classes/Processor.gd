class_name Processor extends Machine
## A processor is a machine in the kitchen
## that optionally consumes an item and optionally produces an item
## 
## The player can interact with it
## interaction with processors are lower priority than interactions with carryables

## these are the states that this processor can be in - like a state machine
var states: Array[PState] = []

## this is the processor's current state
var currentState: PState

## while in transition, the processor won't accept interactions
var inTransition: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var progress: ProgressBar = $ProgressBar

## this method is called from the player's interactive area.
## itemData can be null if the player's hand is empty.
func interact(player: PlayerController, item: Carryable) -> void:
	if (inTransition):
		return
	
	var itemId: String = ""
	if item != null:
		itemId = item.getData().id
	
	if currentState.stateTransitions.keys().has(itemId):
		var transition: PStateTransition = currentState.stateTransitions[itemId]
		assert(transition.displayFramesDuringTransition.size() == transition.duration.size(), "transition set up improperly")
		
		inTransition = true
		if transition.requiresPlayerAttention:
			player.canMove = false
		
		for transitStop in (transition.displayFramesDuringTransition.size()-1):
			sprite.frame = transition.displayFramesDuringTransition[transitStop]
			await get_tree().create_timer(transition.duration[transitStop]).timeout
		
		currentState = transition.stateAfter
		print("product: ", currentState.product, " produced")
		var product = currentState.product.instantiate()
		#TODO add data to product
		player.placeIteminHand(product)
		inTransition = false

## a State contains all information to handle player interactions
## and possibly as a result of them, transition to a different state
class PState extends Resource:
	## texture to display in this state
	var displayFrame: int
	## acceptable ids that trigger a state transition
	var stateTransitions: Dictionary[String, PStateTransition]
	## optional product to instantiate when entering this state
	var product: PackedScene = null
	
	func _init(frameForState: int, productOrNull: PackedScene):
		displayFrame = frameForState
		product = productOrNull
	
	## Transitions require a "stateAfter", therefore they need to be added after initializing states
	func addTransition(id: String, transit: PStateTransition) -> PState:
		stateTransitions.set(id, transit)
		return self

## a StateTransition contains all information needed to display the machine as it
## is processing a player interaction and whether the player needs to remain glued to it
class PStateTransition extends Resource:
	## textures to display while transitioning
	var displayFramesDuringTransition: Array[int]
	## times for each texture and total: duration
	var duration: Array[float]
	## the state for the processor after all durations
	var stateAfter: PState
	## whether the player may move when this transition begins
	var requiresPlayerAttention: bool
	
	func _init(framesDuringTransit: Array[int], transitDuration: Array[float], nextState: PState, reqPlayer: bool):
		displayFramesDuringTransition = framesDuringTransit
		duration = transitDuration
		stateAfter = nextState
		requiresPlayerAttention = reqPlayer
