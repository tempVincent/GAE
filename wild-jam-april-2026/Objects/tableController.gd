extends StaticBody2D

var playerInArea: bool

@onready var Area = $Area2D

## overrides base class listener
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = true

## overrides base class listener
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = false
