class_name Processor extends StaticBody2D

var states: Array[ProcessState]
var currentState: ProcessState

func _ready() -> void:
	#var stateOneStart: ProcessState = ProcessState.new().initialize(null,null,"")
	#var stateTwoVariantOne: ProcessState = ProcessState.new().initialize(null,null,"")
	#var stateTwoVariantTwo: ProcessState = ProcessState.new().initialize(null,null,"")
	#var stateThreeEnd: ProcessState = ProcessState.new().initialize(null,null,"")
	
	#stateOneStart.setTransitions({"item1":stateTwoVariantOne,"item2":stateTwoVariantTwo})
	#stateTwoVariantOne.setTransitions({"item2":stateThreeEnd})
	#stateTwoVariantTwo.setTransitions({"item1":stateThreeEnd})
	#stateThreeEnd.setTransitions({"3->1":stateOneStart})
	
	#states = [stateOneStart,stateTwoVariantOne,stateTwoVariantTwo,stateThreeEnd]
	#currentState = states[0]
	pass

func process(c: Carryable) -> Carryable:
	if currentState.stateTransitions.keys().has(c.get_global_name()):
		var carrier: Node2D = c.get_parent()
		carrier.remove_child(c)
		c.isBeingCarried = false
		currentState = currentState.stateTransitions[c.get_global_name()]
		if currentState.product != null:
			carrier.add_child(currentState.product)
			currentState.product.isBeingCarried = true
			return currentState.product
		else:
			return null
	else:
		return null

class ProcessState:
	var sprite: Sprite2D
	var productCarryable: Carryable
	var productScene: PackedScene
	var stateTransitions: Dictionary[String,ProcessState]

	func initialize(spr: Sprite2D, pc: Carryable, psPath: String) -> ProcessState:
		sprite = spr
		productCarryable = pc
		productScene = load(psPath)
		return self

	func setTransitions(st: Dictionary[String,ProcessState]) -> void:
		stateTransitions = st
