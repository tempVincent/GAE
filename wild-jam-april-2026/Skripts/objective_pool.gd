extends Node
enum objectives{
	coffee,
	fruits,
	water
}
signal objectives_updated
const objs:Array[objectives] = [objectives.coffee, objectives.fruits, objectives.water]
var current_objective:objectives = _get_random_Task()
var next_objective: objectives = _get_random_Task()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	objectives_updated.emit()
	randomize()
	pass # Replace with function body.
	
func _complete_current_objective():
	current_objective = next_objective
	next_objective = _get_random_Task()
	objectives_updated.emit()
	
func _get_random_Task() -> objectives:
	return objs[randi()%objs.size()]

func get_objective_text(obj: objectives) -> String:
	match obj:
		objectives.coffee:
			return "Coffee"
		objectives.fruits:
			return "Fruits"
		objectives.water:
			return "Water"
		_:
			return "Unknown"
