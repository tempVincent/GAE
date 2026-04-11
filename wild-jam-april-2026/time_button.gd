extends Node2D
@onready var lineText:LineEdit = $LineEdit
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add method call for getting selected difficulty
	#then set time left
	lineText.text = "Time left: " + str(timer.time_left)
	pass # Replace with function body.

func _timer(difficulty):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
