extends Node
enum objectives{
	coffee,
	fruits,
	water
}
signal objectives_updated
signal difficulty_updated

const objs:Array[objectives] = [objectives.coffee, objectives.fruits, objectives.water]
var current_objective:objectives = _get_random_Task()
var next_objective: objectives = _get_random_Task()
var difficulty: int = 0
var completed_obj = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	objectives_updated.emit()
	randomize()
	pass # Replace with function body.
	
func _complete_current_objective():
	current_objective = next_objective
	next_objective = _get_random_Task()
	_update_completed()
	objectives_updated.emit()
	
func _get_random_Task() -> objectives:
	return objs[randi()%objs.size()]
	
func _update_difficulty(new_diff :int):
	difficulty= new_diff
	difficulty_updated.emit()
	completed_obj = 0
	
func _update_completed():
	completed_obj +=1
	print(completed_obj)
	
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
