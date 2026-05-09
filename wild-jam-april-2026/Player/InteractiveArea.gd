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

var interactiveMachines: Array[String] = ["res://Objects/coffeMachine.tscn", "res://Objects/water.tscn", "res://Objects/mixer.tscn"]
# this array is supposed to be ordered in order of priority of interaction descending
var interactiveCarriables: Array[String] = ["res://Objects/Fruit.tscn", "res://Objects/coffee_can.tscn"]
var interactiveObjects: Array[String] = []
var inRangeObjects: Array[Node2D]

func _ready() -> void:
	interactiveObjects.append_array(interactiveMachines)
	interactiveObjects.append_array(interactiveCarriables)

func _on_body_entered(body: Node2D) -> void:
	if  interactiveObjects.has(body.scene_file_path):
		inRangeObjects.append(body)
		
		#UI for Interaction
		if  interactiveMachines.has(body.scene_file_path):
			var uiOverlay = body.get_node("Interact")
			if uiOverlay != null:
				uiOverlay.visible = true

func _on_body_exited(body: Node2D) -> void:
	if inRangeObjects.has(body):
		inRangeObjects.erase(body)
		
		#UI for Interaction
		if  interactiveMachines.has(body.scene_file_path):
			var uiOverlay = body.get_node("Interact")
			if uiOverlay != null:
				uiOverlay.visible = false

func _get_interactiveObject():
	var itemJustPickedUp = false
	
	if not inRangeObjects.is_empty():
		## prioritize interacting
		if character.itemInHand == null:
			## prioritize interacting with a pickable object
			var carriables = inRangeObjects.filter(func(obj): return obj.is_in_group("pickable"))
			if not carriables.is_empty():
				## sort carriables in priority order descending
				assert(carriables.all(func(obj): return interactiveCarriables.has(obj.scene_file_path)), "not all carriables added to interactiveCarriables")
				carriables.sort_custom(func(obj1, obj2): return (interactiveCarriables.find(obj1.scene_file_path) < interactiveCarriables.find(obj2.scene_file_path)))
				var item = carriables.front()
				print("picking up an item: ", item)
				pickUpItem(item)
				itemJustPickedUp = true
			else:
				## prioritize interacting with a producer
				var producer = inRangeObjects.filter(func(obj): return obj.is_in_group("producer")).front()
				if producer != null:
					print("interacting with a producer")
					producer.interact(character, null)
		else:
			## prioritize interacting with a processor
			var processors = inRangeObjects.filter(func(obj): return obj.is_in_group("processor"))
			assert(processors.size() <= 1, "some processors are too close to each other")
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

func pickUpItem(item: Node2D) -> void:
	character.itemInHand = item
	item.get_parent().remove_child(item)
	character.get_node("AnimatedSprite2D/Hand").add_child(item)
	if item.scene_file_path == "res://objects/fruit.tscn":
		item.set_collision_mask_value(2, true)

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
