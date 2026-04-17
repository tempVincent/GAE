class_name Processor extends Machine

var states: Array[ProcessState]
var currentState: ProcessState

signal stateChanged

func process(p: Portable) -> Portable:
	print ("begin processing: " + p.get_script().get_global_name())
	if currentState.stateTransitions.keys().has(p.get_script().get_global_name()):
		print ("key found")
		var carrier: Node2D = p.get_parent()
		carrier.remove_child(p)
		p.isBeingCarried = false
		currentState = currentState.stateTransitions[p.get_script().get_global_name()]
		stateChanged.emit()
		while currentState.isAutoTransition:
			print("awaiting state change")
			await get_tree().create_timer(currentState.timeoutBeforeAutoTransition).timeout
			currentState = currentState.autoTransitionTo
			stateChanged.emit()
		
		print("final state reached for this interaction")
		if currentState.product != null:
			var product: Portable = currentState.product.instantiate()
			carrier.add_child(product)
			product.global_position = carrier.global_position
			product.isBeingCarried = true
			product.freeze = true
			product.collision.disabled = true
			product.scale = Vector2(0.5,0.5)
			p.queue_free()
			return product
		else:
			# interaction successful, p consumed
			p.queue_free()
			return null
	else:
		# interaction not possible, return p
		print ("key not found")
		return p

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
