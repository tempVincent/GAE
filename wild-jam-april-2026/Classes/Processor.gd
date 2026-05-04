class_name Processor extends StaticBody2D
## A processor is a machine in the kitchen
## 
## The player can interact with it

## these are the states that this processor can be in - like a state machine
var states: Array[PState]

## this is the processor's current state
var currentState: PState

## while in transition, the processor won't accept interactions
var inTransition: bool = false

#@onready var sprite: Sprite2D = $Sprite2D
#@onready var progbar: ProgressBar = $ProgressBar
#@onready var timer: Timer = $Timer

## this method is called from the player's interactive area.
## carriedObject can be null if the player's hand is empty.
## returns true if the player is required to stay at the machine during transition. 
## Alternatively, PlayerController can be accessed directly and canMove can be set to false for the transit duration
func interact2(player: PlayerController, carriedObject: Carryable) -> bool:
	if (inTransition):
		return false
	else:
		#TODO handle interaction
		#if object is in currentState.stateTransitions.keys ...
		#...
		#...
		#...
		#after initiating the state transition, return currentState.stateTransitions[object].requiresPlayerAttention
		
		return false

## a State or contains all information to handle player interactions
## and possibly as a result of them, transition to a different state
class PState extends Resource:
	var displayTexture: Texture2D
	var stateTransitions: Dictionary[String, PStateTransition]
	var product: Carryable = null
	
	func _init(texForState: Texture2D, productOrNull: Carryable):
		displayTexture = texForState
		product = productOrNull
	
	## Transitions require a "stateAfter", therefore they need to be added after initializing states
	## the function returns the instance to make absolutely disgusting instantiation chains possible
	func addTransition(carryableId: String, transit: PStateTransition) -> PState:
		stateTransitions.set(carryableId, transit)
		return self

## a StateTransition contains all information needed to display the machine as it
## is processing a player interaction and whether the player needs to remain glued to it
class PStateTransition extends Resource:
	var displayTextureDuringTransition: Texture2D
	var durationSeconds: float
	var requiresPlayerAttention: bool
	var stateAfter: PState
	
	func _init(texDuringTransit: Texture2D, transitDuration: float, reqPlayer: bool, newState: PState):
		displayTextureDuringTransition = texDuringTransit
		durationSeconds = transitDuration
		requiresPlayerAttention = reqPlayer
		stateAfter = newState
