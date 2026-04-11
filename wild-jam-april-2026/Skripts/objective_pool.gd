extends Node
enum objectives{
	coffee,
	fruits,
	water
}
signal objectives_updated

var current_objective:objectives = _get_random_Task()
var next_objective: objectives = _get_random_Task()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _complete_current_objective():
	current_objective = next_objective
	next_objective = _get_random_Task()
	objectives_updated.emit()
	
func _get_random_Task() -> objectives:
	return objectives.coffee

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
