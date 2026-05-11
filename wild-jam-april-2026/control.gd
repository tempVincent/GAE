extends Control

func _on_button_2_pressed() -> void:
	print("pressed" + str(self.visible))
	self.visible = !self.visible
	print("visible: " + str(self.visible))

func _on_button_button_down() -> void:
	print("pressed" + str(self.visible))
	self.visible = !self.visible
	print("visible: " + str(self.visible))
	
