extends Area2D
var coffee_can
var inRangeObjects:Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_body_entered(body: Node2D):
	if body.scene_file_path == "res://root/WorkInProgress/Objects/CoffeeCan":
		inRangeObjects.append(body)
		print("I see: Coffe CAn")
	
	if body.scene_file_path == "res://Objects/coffeMachine.tscn":
		inRangeObjects.append(body)
		print("i see: CoffeMachine")
	else:
		print("Johhny:%s" + str(body.get_path()))
