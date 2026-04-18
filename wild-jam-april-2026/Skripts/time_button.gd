extends Node2D
@onready var label:Label = $Label
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.difficulty_updated.connect(_updated_time)

	#add method call for getting selected difficulty
	#then set time left
	timer.wait_time = 300.0 / (ObjectivePool.difficulty+1)
	timer.start()
	label.text = "Time left: " + str(timer.time_left)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Time left: " + str(int(timer.time_left))
	
func _updated_time():
	timer.wait_time = 300.0 / (ObjectivePool.difficulty+1)
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://gameEndMenu.tscn")
	if(ObjectivePool.completed_obj >= 10):
		print ("Player won")
	else:
		print("Player lost")
	pass # Replace with function body.
