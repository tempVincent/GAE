extends Button

@onready var menu:HBoxContainer = $"../../../.."
@onready var title:TextureRect = $"../../../../../TextureRect"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	title.visible = false
	menu.visible = false
	
	pass # Replace with function body.
