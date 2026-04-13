extends OptionButton
func _ready():
	self.select(0)
	
func _on_item_selected(index: int) -> void:
	ObjectivePool._update_difficulty(index)
