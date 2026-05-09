class_name CoffeeMachine extends Processor

var worktime = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished = false
	progress.value = 100

func interact(player: PlayerController, object: Variant) -> void:
	if object != null:
		##POSITION
		for child in object.get_children():
			print("Child:", child, " visible:", child.visible)
		object.visible = false
		#player.canMove = false
		progress.visible = true
		var items = get_tree().current_scene.get_node("Objects")
		object.reparent(items)
		player.itemInHand = null
		object.freeze = false

		var collision = object.get_node("CollisionPolygon2D")
		collision.disabled = false
		object.global_position = Vector2(400,600)
		var transitionIN:Tween = get_tree().create_tween()
		transitionIN.tween_property(progress,"value",0,worktime)
		
		sprite.texture = preload("res://assets/Objects/CoffeMachine beans.png")
		##Make Can invisible
		await get_tree().create_timer(float(worktime)/2).timeout
		sprite.texture = preload("res://assets/Objects/CoffeMachine beans_filled.png")
		##Disable movement of player
		##Create new SPrite with Can and water and show it
		await get_tree().create_timer(float(worktime)/2).timeout
		sprite.texture = preload("res://assets/Objects/CoffeMachine beans NoCan.png")
		
		transitionIN.kill()
		progress.visible = false
		progress.value = 100
		
		#player.canMove = true
		object.visible = true
		object.isInHand = false
		player.Hand.remove_child(object)
		##make can visible
		
		print("Kanne pos: ", object.global_position)
		print("visible: ", object.visible)
		print("z_index: ", object.z_index)

		if object.scene_file_path == "res://Objects/coffee_can.tscn":
			var p = object.get_node("Sprite2D")
			print(p)
			p.texture = preload("res://assets/Objects/CoffeCan.png")

		else:
			await get_tree().create_timer(5.0).timeout
