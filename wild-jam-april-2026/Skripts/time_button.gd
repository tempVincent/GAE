extends Node2D

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.difficulty_updated.connect(_updated_time)

	#add method call for getting selected difficulty
	#then set time left
	timer.wait_time = 200.0 / (ObjectivePool.difficulty+1)
	timer.start()
	label.text = "Time left: " + str(timer.time_left)

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Time left: " + str(int(timer.time_left))
	if ObjectivePool.completed_obj == ObjectivePool.objs_toComplete:
		_on_timer_timeout()

##
func _updated_time():
	timer.wait_time = 200.0 / (ObjectivePool.difficulty+1)
	timer.start()

## 
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://gameEndMenu.tscn")
	if(ObjectivePool.completed_obj >= 10):
		print ("Player won")
	else:
		print("Player lost")
