extends Area2D
var coffee_can
var inRangeObjects:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_area_entered(body: Node2D):
	if body.scene_file_path == "res://Objects/coffee_can.tscn":
		inRangeObjects.append(body)
		print("Coffe CAn")
	
	if body.scene_file_path == "res://Objects/coffeMachine.tscn":
		inRangeObjects.append(body)
		print("CoffeMachine")
	else:
		print("Unknown Object")
