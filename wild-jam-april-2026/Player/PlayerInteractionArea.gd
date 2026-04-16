extends Area2D

var inRangeObjects: Array

@onready var characterAnimation = $"../AnimatedSprite2D"
@onready var character = $".."
@onready var hand = $"../AnimatedSprite2D/Hand"
@onready var Objects:Node2D = $"../../Objects"
@onready var table:StaticBody2D = $"../../Funiture/Table"
@onready var coffetable:StaticBody2D = $"../../Furniture/CoffeeTable"
@onready var interactionareas:Node2D = $"../../Areas"

func _process(delta: float) -> void:
	if characterAnimation.flip_h:
		scale.x = -1
	else:
		scale.x = 1

func _on_body_entered(body: Node2D) -> void:
	if body.scene_file_path == "res://Objects/coffeeCan.tscn":
		inRangeObjects.append(body)
		print("Coffee Can")
	
	if body.scene_file_path == "res://Objects/coffeeMachine.tscn":
		inRangeObjects.append(body)
		print("Coffee Machine")
	
	if body.scene_file_path == "res://Objects/sink.tscn":
		inRangeObjects.append(body)
		print("WaterArea")

func _on_body_exited(body: Node2D) -> void:
	if inRangeObjects.has(body):
		inRangeObjects.erase(body)

func _get_interactiveObject():
	var itemJustPickedUp = false
	
	if !inRangeObjects.is_empty():
		var item:Node2D = inRangeObjects[0]
		
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
		##coffee can be picked up (when picked up, disable collision), and set state for player "carrying"
		##coffee can be placed at coffeemachine
		##coffee can be picked up from coffeemachine
		##coffeeMachine can be started
		print(inRangeObjects[0])
		##then rescan
		#endregion
		
		#region nicht aufhebbare Items
		if !item.is_in_group("pickable"):
			if character.itemInHand:
				item.interact(character, hand.get_child(0))
			else:
				item.interact(null, null)
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
