extends Button

@onready var settings:HBoxContainer = $"../../../../../HBoxContainer2"
@onready var menu:HBoxContainer = $"../../../.."
@onready var title:TextureRect = $"../../../../../TextureRect"

## 
func _on_button_down() -> void:
	settings.visible = true
	title.visible = false
	menu.visible = false # Replace with function body.
