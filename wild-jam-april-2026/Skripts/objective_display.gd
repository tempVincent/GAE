extends Node2D
@onready var label :Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.objectives_updated.connect(_get_current_objective)

func _get_current_objective():
	# add function + finction call to get objective
	var obj = ObjectivePool.get_objective_text(ObjectivePool.current_objective)
	label.text = "Current Objective: get " +obj
	pass
