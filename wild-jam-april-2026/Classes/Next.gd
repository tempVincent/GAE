extends Node2D
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.objectives_updated.connect(_obj)
	_obj()
	
#add function to get and display next objective
func _obj():
	var obj = ObjectivePool.get_objective_text(ObjectivePool.next_objective)
	label.text = "Next Objective: get " + obj
