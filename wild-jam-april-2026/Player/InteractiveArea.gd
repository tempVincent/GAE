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
		#print("Coffe CAn")
	
	if body.scene_file_path == "res://Objects/coffeMachine.tscn":
		inRangeObjects.append(body)
		#print("CoffeMachine")
	
	if body.scene_file_path == "res://Objects/water.tscn":
		inRangeObjects.append(body)
		#print("WaterArea")
	
	if body.scene_file_path == "res://objects/fruit.tscn":
		inRangeObjects.append(body)
		print("Fruit")
	
	if body.scene_file_path == "res://Objects/mixer.tscn":
		inRangeObjects.append(body)


func _on_body_exited(body: Node2D) -> void:
	if inRangeObjects.has(body):
		inRangeObjects.erase(body)
	pass # Replace with function body.


func _get_interactiveObject():
	var itemJustPickedUp = false
	
	if !inRangeObjects.is_empty():
		
		var matches = inRangeObjects.filter(func(item): return item.scene_file_path == "res://objects/fruit.tscn")
		var item:Node2D = matches[0] if not matches.is_empty() else inRangeObjects[0]
		#var item:Node2D = inRangeObjects[0]
		
		
		
		##ITEMS DIE MAN AUFHEBEN KANN
		#region Aufhebbare ITEMS
		if item.is_in_group("pickable"):
			
			##PICKUP ITEM
			if character.itemInHand == null:
				character.itemInHand = item
				item.get_parent().remove_child(item)
				character.get_node("AnimatedSprite2D/Hand").add_child(item)
				itemJustPickedUp = true

				if item.scene_file_path == "res://objects/fruit.tscn":
					item.set_collision_mask_value(2, true)
		
		print(inRangeObjects[0])
		
		##then rescan
	
	
		
		#endregion
		
		#region nicht aufhebbare Items
		print("Interact Mixer")
		if !item.is_in_group("pickable"):
			if character.itemInHand:
				if (item.scene_file_path == "res://Objects/coffeMachine.tscn" or item.scene_file_path == "res://Objects/water.tscn") and hand.get_child(0).scene_file_path == "res://Objects/coffee_can.tscn":
					item.interact(character, hand.get_child(0))
				if  (item.scene_file_path == "res://Objects/mixer.tscn"):
					
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
			
			
