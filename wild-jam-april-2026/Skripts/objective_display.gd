extends Node2D

@onready var label :Label = $Node2D/Label
@onready var objPool = preload("res://Skripts/objective_pool.gd")

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.objectives_updated.connect(_get_current_objective)
	_get_current_objective()

## 
func _get_current_objective():
	# add function + finction call to get objective
	await get_tree().create_timer(0.5).timeout
	var obj = ObjectivePool.get_objective_text(ObjectivePool.current_objective)
	
	if (str(obj) == "banana"):
		obj = "fruit"
	label.text = "Current Objective: \nget " +obj
