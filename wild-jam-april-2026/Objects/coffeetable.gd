extends StaticBody2D

var playerInArea:bool
@onready var Area = $Area2D
# Called when the node enters the scene tree for the first time.




func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = true
	pass # Replace with function body.


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.scene_file_path == "res://Player/silvester.tscn":
		playerInArea = false
	pass # Replace with function body.
