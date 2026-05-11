class_name CoffeeMachine extends Processor

var worktime = 3

@onready var audioStream: AudioStreamPlayer2D = $AudioStreamPlayer2D

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress.value = 100

## Called by the player's interactive area
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
		object.global_position = Vector2(505,530)
		var transitionIN:Tween = get_tree().create_tween()
		transitionIN.tween_property(progress,"value",0,worktime)
		audioStream.play()
		
		
		sprite.frame = 1
		##Make Can invisible
		await get_tree().create_timer(float(worktime)/2).timeout
		sprite.frame = 2
		##Disable movement of player
		##Create new Sprite and show it
		await get_tree().create_timer(float(worktime)/2).timeout
		sprite.frame = 0
		
		transitionIN.kill()
		progress.visible = false
		progress.value = 100
		audioStream.stop()
		
		#player.canMove = true
		object.visible = true
		#player.Hand.remove_child(object)
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
