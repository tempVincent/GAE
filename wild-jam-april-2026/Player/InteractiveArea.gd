extends Area2D

@onready var characterAnimation = $"../AnimatedSprite2D"
@onready var character = $".."
@onready var hand = $"../AnimatedSprite2D/Hand"
@onready var Objects: Node2D = $"../../Objects"
@onready var table: StaticBody2D = $"../../Funiture/Table"
@onready var coffetable: StaticBody2D = $"../../Funiture/CoffeeTable"
@onready var interactionareas: Node2D = $"../../Areas"
@onready var collisionShape: CollisionShape2D = $"CollisionShape2D"
@onready var interactionUI = preload("res://assets/UI/KeyboardUI/keyboard_s_outline.png")

var interactiveObjects: Array = ["res://Objects/coffee_can.tscn","res://Objects/coffeMachine.tscn",
								"res://Objects/water.tscn","res://Objects/Fruit.tscn","res://Objects/mixer.tscn"]
var inRangeObjects: Array[Node2D]

func _on_body_entered(body: Node2D) -> void:
	if  interactiveObjects.find(body.scene_file_path) != -1:
		inRangeObjects.append(body)
		
		#UI for Interaction
		var uiOverlay = body.get_node("Interact")
		if uiOverlay != null:
			uiOverlay.visible = true

func _on_body_exited(body: Node2D) -> void:
	if inRangeObjects.has(body):
		inRangeObjects.erase(body)
		
		#UI for Interaction
		var uiOverlay = body.get_node("Interact")
		if uiOverlay != null:
			uiOverlay.visible = false

func _get_interactiveObject():
	var itemJustPickedUp = false
	
	if not inRangeObjects.is_empty():
		## prioritize interacting
		if character.itemInHand == null:
			## prioritize interacting with a pickable object
			var pickables = inRangeObjects.filter(func(obj): return obj.is_in_group("pickable"))
			if not pickables.is_empty():
				## prioritize interacting with the coffee can
				var item = pickables.filter(func(obj): return obj.scene_file_path == "res://Objects/coffee_can.tscn").front()
				## prioritize interacting with another pickable item
				if item == null:
					item = pickables.front()
				
				print("picking up an item")
				character.itemInHand = item
				item.get_parent().remove_child(item)
				character.get_node("AnimatedSprite2D/Hand").add_child(item)
				itemJustPickedUp = true
				if item.scene_file_path == "res://objects/fruit.tscn":
					item.set_collision_mask_value(2, true)
			else:
				## prioritize interacting with a producer
				var producer = inRangeObjects.filter(func(obj): return obj.is_in_group("producer")).front()
				if producer != null:
					print("interacting with a producer")
					producer.interact(character, null)
		else:
			## prioritize interacting with a processor
			var processors = inRangeObjects.filter(func(obj): return obj.is_in_group("processor"))
			assert(processors.size() <= 1, "")
			var processor = processors.front()
			if processor != null:
				match character.getItemInHand().scene_file_path:
					"res://Objects/coffee_can.tscn":
						if processor.scene_file_path == "res://Objects/coffeMachine.tscn" or processor.scene_file_path == "res://Objects/water.tscn" or processor.scene_file_path == "res://Objects/mixer.tscn":
							print("filling a coffee can")
							processor.interact(character, null)
					"res://Objects/Fruit.tscn":
						if processor.scene_file_path == "res://Objects/mixer.tscn":
							print("putting fruit in mixer")
							processor.interact(character, null)
	else:
		## drop held item
		if character.itemInHand != null and !itemJustPickedUp:
			print("dropping held item")
			dropHeldItem()

func dropHeldItem() -> void:
	var obj: Node2D = hand.get_child(0)
	if interactionareas.canPlaceObject:
		var oldPos = obj.global_position
		print(oldPos)
		var newPos = oldPos
		if interactionareas.playerInArea:
			newPos.y -= 150
			var moveCan: Tween = get_tree().create_tween()
			moveCan.tween_property(obj, "global_position", newPos, 0.25)
			await moveCan.finished
			moveCan.kill()
		hand.remove_child(obj)
		Objects.add_child(obj)
		obj.global_position = newPos
		character.itemInHand = null
