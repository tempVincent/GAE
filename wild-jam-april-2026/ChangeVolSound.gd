extends HSlider

signal volChanged

@onready var settings= $"/root/GlobalVars"

## override base class listener
func _on_drag_ended(value_changed: bool) -> void:
	settings.musicVol = value
	volChanged.emit()
