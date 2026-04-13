extends Area2D
var coffee_can
var inRangeObjects:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_body_entered(body: Node2D):
	var path = body.get_path()
	if str(path) == "/root/WorkInProgress/Objects/CoffeeCan":
		if ObjectivePool.current_objective == ObjectivePool.objectives.coffee:
			print("Objective completed")
			ObjectivePool._complete_current_objective()
		inRangeObjects.append(body)
	
	elif str(path) == "res://Objects/coffeMachine.tscn":
		inRangeObjects.append(body)
		print("i see: CoffeMachine")
	else:
		print("Johhny:" + str(body.get_path()))
