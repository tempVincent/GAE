extends Node2D
@onready var label :Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_get_current_objective()
	pass # Replace with function body.

func _get_current_objective():
	# add function + finction call to get objective
	var obj = "Get coffe"
	label.text = "Current Objective: " +obj
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
