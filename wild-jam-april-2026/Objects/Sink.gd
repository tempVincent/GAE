class_name Sink extends Processor

var worktime = 3
@onready var audioStream: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished = false
	progress.value = 100
	sprite.frame = 0

func interact(player: PlayerController, object: Variant) -> void:
	if sprite.frame == 0:
		sprite.frame = 1
	
		if object != null:
			##POSITION
			var p = object.get_child(1)
			if p.texture == preload("res://assets/objects/EmptyWaterCan.png"):
				sprite.frame = 2
			object.visible = false
			var items = get_tree().current_scene.get_node("Objects")
			object.reparent(items)
			player.itemInHand = null
			object.freeze = false
			var collision = object.get_node("CollisionPolygon2D")
			collision.disabled = false
			object.global_position = Vector2(50,450)
			player.Hand.remove_child(object)
			##Make Can invisible
			##Disable movement of player
			##Create new Sprite with Can and water and show it
			progress.visible = true
			var transitionIN:Tween = get_tree().create_tween()
			transitionIN.tween_property(progress,"value",0,worktime)
			audioStream.play(0)
			
			
			await get_tree().create_timer(worktime).timeout
			transitionIN.kill()
			progress.visible = false
			progress.value = 100
			
			player.canMove = true
			object.visible = true
			audioStream.stop()
			##make can visible
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				if p.texture == preload("res://assets/Objects/WaterCan.png") or p.texture == preload("res://assets/Objects/CoffeCan.png") or  p.texture == preload("res://assets/Objects/CoffeCan-juice-banana.png")  :
					p.texture = preload("res://assets/objects/EmptyWaterCan.png")
				else:
					p.texture = preload("res://assets/Objects/WaterCan.png")
				pass
		else:
			progress.visible = true
			var transitionIN:Tween = get_tree().create_tween()
			transitionIN.tween_property(progress,"value",0,worktime)
			
			await get_tree().create_timer(worktime).timeout
			transitionIN.kill()
			progress.visible = false
			progress.value = 100
		sprite.frame = 0
	pass
