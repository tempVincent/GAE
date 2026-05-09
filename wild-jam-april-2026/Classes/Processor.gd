class_name Processor extends Machine
## A processor is a machine in the kitchen
## 
## The player can interact with it
## interaction with processors are lower priority than interactions with carryables

var finished: bool = false

## these are the states that this processor can be in - like a state machine
var states: Array[PState]

## this is the processor's current state
var currentState: PState

## while in transition, the processor won't accept interactions
var inTransition: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var progress: ProgressBar = $ProgressBar

## this method is called from the player's interactive area.
## object/carriedObjectData can be null if the player's hand is empty.
## Alternatively, PlayerController can be accessed directly and canMove can be set to false for the transit duration
func interact(player: PlayerController, item: Carryable):
	if (!finished):
		pass
	if (inTransition):
		pass
	if (item == null):
		pass
	else:
		var itemData: Resource = item.getData()
		#TODO handle interaction
		#if object is in currentState.stateTransitions.keys ...
		#...
		#...
		#...
		#check currentState.stateTransitions[object].requiresPlayerAttention
		pass

## a State contains all information to handle player interactions
## and possibly as a result of them, transition to a different state
class PState extends Resource:
	## texture to display in this state
	var displayTexture: Texture2D
	## acceptable ids that trigger a state transition
	var stateTransitions: Dictionary[String, PStateTransition]
	## optional product to instantiate when entering this state
	var product: Carryable = null
	
	func _init(texForState: Texture2D, productOrNull: Carryable):
		displayTexture = texForState
		product = productOrNull
	
	## Transitions require a "stateAfter", therefore they need to be added after initializing states
	func addTransition(id: String, transit: PStateTransition) -> PState:
		stateTransitions.set(id, transit)
		return self

## a StateTransition contains all information needed to display the machine as it
## is processing a player interaction and whether the player needs to remain glued to it
class PStateTransition extends Resource:
	## textures to display while transitioning
	var displayTextureDuringTransition: Array[Texture2D]
	## times for each texture and total: duration
	var duration: Array[float]
	## the state for the processor after all durations
	var stateAfter: PState
	## whether the player may move when this transition begins
	var requiresPlayerAttention: bool
	
	func _init(texDuringTransit: Array[Texture2D], transitDuration: Array[float], nextState: PState, reqPlayer: bool):
		displayTextureDuringTransition = texDuringTransit
		duration = transitDuration
		stateAfter = nextState
		requiresPlayerAttention = reqPlayer
