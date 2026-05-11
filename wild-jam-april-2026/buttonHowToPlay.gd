extends Button

@onready var menu:HBoxContainer = $"../../../.."
@onready var title:TextureRect = $"../../../../../TextureRect"
@onready var tutorial: HBoxContainer = $"../../../../../HBoxContainer4"
@onready var control: Control = $"../../../../../HBoxContainer4"

## override base class listener
func _on_button_down() -> void:
	tutorial.visible = true
	control.visible = true
	title.visible = false
	menu.visible = false
