extends Node2D

var playerInArea:bool
@onready var Area = $Area2D
var canPlaceObject:bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canPlaceObject = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
		#canPlaceObject = false
