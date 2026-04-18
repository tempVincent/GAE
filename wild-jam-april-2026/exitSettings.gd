extends Button

@onready var settings:HBoxContainer = $"../../../.."
@onready var menu:HBoxContainer = $"../../../../../HBoxContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	settings.visible = false
	menu.visible = true
	
	
	
	pass # Replace with function body.
