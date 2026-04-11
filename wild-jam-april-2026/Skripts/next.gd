extends Node2D
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.objectives_updated.connect(_obj)
	pass # Replace with function body.
	
#add function to get and display next objective
func _obj():
	var obj = str(ObjectivePool.next_objective)
	label.text = "Next Objective: " + obj
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
