extends Node2D

var playerInArea:bool
var canPlaceObject:bool

@onready var Area = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canPlaceObject = true

func _on_body_entered(body: Node2D, canPlace: bool) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = true
		if canPlace:
			canPlaceObject = true
		else:
			canPlaceObject = false

func _on_body_exited(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = false
