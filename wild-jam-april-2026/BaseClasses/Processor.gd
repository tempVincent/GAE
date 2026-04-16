class_name Processor extends StaticBody2D

var states: Array[ProcessState]
var currentState: ProcessState

func process(p: Portable) -> Portable:
	if currentState.stateTransitions.keys().has(p.get_global_name()):
		var carrier: Node2D = p.get_parent()
		carrier.remove_child(p)
		p.isBeingCarried = false
		currentState = currentState.stateTransitions[p.get_global_name()]
		p.queue_free()
		while currentState.isAutoTransition:
			await get_tree().create_timer(currentState.timeoutBeforeAutoTransition).timeout
			currentState = currentState.autoTransitionTo
		if currentState.product != null:
			var product: Portable = currentState.product.instantiate()
			carrier.add_child(product)
			currentState.product.isBeingCarried = true
			return product
		else:
			return null
	else:
		return null

class ProcessState:
	var texture: CompressedTexture2D
	var stateTransitions: Dictionary[String, ProcessState]
	
	var isAutoTransition: bool = false
	var autoTransitionTo: ProcessState
	var timeoutBeforeAutoTransition: int
	
	var product: PackedScene

	func initialize(t: CompressedTexture2D, psp: String) -> ProcessState:
		texture = t
		if psp != "":
			product = load(psp)
		return self

	func setTransition(item: String, next: ProcessState) -> ProcessState:
		stateTransitions.set(item, next)
		return self
		
	func setAutoTransition(next: ProcessState, timeout: int) -> ProcessState:
		isAutoTransition = true
		autoTransitionTo = next
		timeoutBeforeAutoTransition = timeout
		return self
