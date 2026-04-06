extends Node2D

var brett:TileMapLayer
var players:TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brett = $Brett
	players = $Players
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass






func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_position = event.position
			
			var location_brett = brett.local_to_map(mouse_position)
			
			if brett.get_cell_atlas_coords(location_brett) != Vector2i(-1,-1):
				print("brett")
			print(location_brett)
