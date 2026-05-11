extends StaticBody2D

var playerInArea:bool

@onready var Area = $Area2D2

## override base class listener
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = true
		
## override base class listener
func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = false
