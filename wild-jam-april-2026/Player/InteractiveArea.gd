extends Area2D

@onready var characterAnimation = $"../AnimatedSprite2D"
@onready var character = $".."
@onready var hand = $"../AnimatedSprite2D/Hand"
@onready var Objects:Node2D = $"../../Objects"
@onready var table:StaticBody2D = $"../../Funiture/Table"
@onready var coffetable:StaticBody2D = $"../../Funiture/CoffeeTable"
@onready var interactionareas:Node2D = $"../../Areas"


var coffee_can
var inRangeObjects:Array


func _ready() -> void:
	pass


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
	
	if body.scene_file_path == "res://Objects/water.tscn":
		inRangeObjects.append(body)
		print("WaterArea")
	


func _on_body_exited(body: Node2D) -> void:
	if inRangeObjects.has(body):
		inRangeObjects.erase(body)
	pass # Replace with function body.


func _get_interactiveObject():
	var itemJustPickedUp = false
	
	if !inRangeObjects.is_empty():
		var item:Node2D = inRangeObjects[0]
		
		
		##ITEMS DIE MAN AUFHEBEN KANN
		#region Aufhebbare ITEMS
		if item.is_in_group("pickable"):
			
			##PICKUP ITEM
			if character.itemInHand == null:
				character.itemInHand = item
				item.get_parent().remove_child(item)
				character.get_node("AnimatedSprite2D/Hand").add_child(item)
				itemJustPickedUp = true
				#item.position = Vector2(0,0)
				#item.position += Vector2(50,0)
			
				#match 
		##interact with Object
		##coffe can be picked up (when picked up, disable collision), and set state for player "carring"
		##coffee can be placed at coffemachine
		##coffee can be picked up from coffeemachine
		
		##coffeMachine can be started
		
		print(inRangeObjects[0])
		
		##then rescan
	
	
		
		#endregion
		
		#region nicht aufhebbare Items
		
		if !item.is_in_group("pickable"):
			if character.itemInHand:
				item.interact(character, hand.get_child(0))
			else:
				item.interact(null, null)
			pass
		
		
		
		
		#endregion
		
		
		
		
	else:
	
		##DROP ITEMS
		if character.itemInHand and !itemJustPickedUp:
			var object:Node2D = hand.get_child(0)
			
			
			if interactionareas.canPlaceObject:
				var oldPos = object.global_position
				print(oldPos)
				
				
				var newPos = oldPos
				
				
				if interactionareas.playerInArea:
					newPos.y -= 150
					
					var moveCan:Tween = get_tree().create_tween()
					moveCan.tween_property(object,"global_position",newPos,0.25)
					await moveCan.finished
					moveCan.kill()
				
				
				hand.remove_child(object)
				Objects.add_child(object)
				
				
				object.global_position = newPos
				
				character.itemInHand = null
			
			
