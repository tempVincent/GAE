extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_2_pressed() -> void:
	print("pressed" + str(self.visible))
	self.visible = !self.visible
	print("visible: " + str(self.visible))
	pass # Replace with function body.


func _on_button_button_down() -> void:
	print("pressed" + str(self.visible))
	self.visible = !self.visible
	print("visible: " + str(self.visible))
	pass # Replace with function body.
	pass # Replace with function body.
