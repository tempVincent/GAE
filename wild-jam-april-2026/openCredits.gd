extends Button


# Called when the node enters the scene tree for the first time.
@onready var credits:HBoxContainer = $"../../../../../Credits"
@onready var menu:HBoxContainer = $"../../../.."
@onready var title:TextureRect = $"../../../../../TextureRect"

## 
func _on_button_down() -> void:
	credits.visible = true
	title.visible = false
	menu.visible = false # Replace with function body.
