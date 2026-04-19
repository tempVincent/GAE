extends OptionButton
func _ready():
	self.select(ObjectivePool.difficulty)
	
func _on_item_selected(index: int) -> void:
	ObjectivePool._update_difficulty(index)
