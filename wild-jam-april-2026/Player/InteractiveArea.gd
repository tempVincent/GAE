extends Area2D

@onready var characterAnimation = $"../AnimatedSprite2D"
@onready var character = $".."
var coffee_can
var inRangeObjects:Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if characterAnimation.flip_h == true:
		scale.x = -1
	else:
		scale.x = 1



func _on_body_entered(body: Node2D) -> void:
	if body.scene_file_path == "res://Objects/coffee_can.tscn":
		inRangeObjects.append(body)
		print("Coffe CAn")
	
	if body.scene_file_path == "res://Objects/coffeMachine.tscn":
		inRangeObjects.append(body)
		print("CoffeMachine")
	

func _on_body_exited(body: Node2D) -> void:
	if inRangeObjects.has(body):
		inRangeObjects.erase(body)
	pass # Replace with function body.



func _get_interactiveObject():
	if !inRangeObjects.is_empty():
		var item:Node2D = inRangeObjects[0]
		
		if character.itemInHand == null:
			character.itemInHand = item
			item.get_parent().remove_child(item)
			character.get_node("AnimatedSprite2D/Hand").add_child(item)
			item.position = Vector2(0,0)
			#item.position += Vector2(50,0)
			
			#match 
		##interact with Object
		##coffe can be picked up (when picked up, disable collision), and set state for player "carring"
		##coffee can be placed at coffemachine
		##coffee can be picked up from coffeemachine
		
		##coffeMachine can be started
		
		print(inRangeObjects[0])
		
		##then rescan
