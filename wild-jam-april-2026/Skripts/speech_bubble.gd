extends Node2D
@onready var label = $Label
var obj_text = ObjectivePool.get_objective_text(ObjectivePool.current_objective)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "I need " + obj_text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
