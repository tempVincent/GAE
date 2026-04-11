extends Node2D
@onready var label:Label = $Label
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add method call for getting selected difficulty
	#then set time left
	timer.wait_time = 300.0
	timer.start()
	label.text = "Time left: " + str(timer.time_left)
	pass # Replace with function body.

func _timer(difficulty):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Time left: " + str(int(timer.time_left))
	
