extends Button

@onready var settings:HBoxContainer = $"../../../.."
@onready var menu:HBoxContainer = $"../../../../../MainMenu"
@onready var title:TextureRect = $"../../../../../TextureRect"

## override base class listener
func _on_button_down() -> void:
	settings.visible = false
	title.visible = true
	menu.visible = true
