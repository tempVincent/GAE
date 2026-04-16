class_name Consumer extends StaticBody2D

var desiredBeverageName: String
var beverageContainerPackedScene: PackedScene
var chooseNextDesire: Callable = func () -> String: return desiredBeverageName

signal DesireFulfilled

func consume(b: Beverage) -> Tool:
	var carrier: Node2D = b.get_parent()
	carrier.remove_child(b)
	b.isBeingCarried = false
	if b.get_global_name() == desiredBeverageName:
		DesireFulfilled.emit(self)
	b.queue_free()
	desiredBeverageName = chooseNextDesire.call()
	return beverageContainerPackedScene.instantiate()
