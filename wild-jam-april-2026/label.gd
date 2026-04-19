extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ObjectivePool.completed_obj >= ObjectivePool.objs_toComplete:
		self.text= "\nYou won"
	else:
		self.text = "\nYou lost"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
