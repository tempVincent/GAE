extends Node2D
@onready var label: Label = $completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.difficulty_updated.connect(_update_text)
	ObjectivePool.objectives_updated.connect(_update_text)
	_update_text()

func _update_text():
	label.text = "Completed Objectives: " + str(ObjectivePool.completed_obj)
