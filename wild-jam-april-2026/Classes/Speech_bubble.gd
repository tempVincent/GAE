extends Node2D
@onready var label = $Label
var obj_text = ObjectivePool.get_objective_text(ObjectivePool.current_objective)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.objectives_updated.connect(update_speech)
	update_speech()

func update_speech():
	var obj_text = ObjectivePool.get_objective_text(ObjectivePool.current_objective)
	label.text = "I need " + obj_text
