extends Button

@onready var menu:HBoxContainer = $"../../../.."
@onready var title:TextureRect = $"../../../../../TextureRect"
@onready var tutorial: HBoxContainer = $"../../../../../HBoxContainer4"
@onready var control: Control = $"../../../../../HBoxContainer4/AspectRatioContainer/VBoxContainer/Control"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	tutorial.visible = true
	control.visible = true
	title.visible = false
	menu.visible = false
	
	pass # Replace with function body.
