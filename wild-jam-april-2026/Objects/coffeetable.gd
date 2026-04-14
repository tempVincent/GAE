extends StaticBody2D

var playerInArea:bool

@onready var Area = $Area2D

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = true

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = false
