class_name Consumer extends Machine

var desiredBeverageName: String
var beverageContainerPackedScene: PackedScene
var chooseNextDesire: Callable = func () -> String: return desiredBeverageName

signal DesireFulfilled

func consume(p: Portable) -> Variant:
	var carrier: Node2D = p.get_parent()
	carrier.remove_child(p)
	p.isBeingCarried = false
	if p.get_script().get_global_name() == desiredBeverageName:
		DesireFulfilled.emit(self)
	p.queue_free()
	desiredBeverageName = chooseNextDesire.call()
	return beverageContainerPackedScene.instantiate()
