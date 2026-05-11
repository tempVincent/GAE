class_name Sink extends Processor

var worktime = 3


@onready var audioStream: AudioStreamPlayer2D = $AudioStreamPlayer2D

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var state1: PState = PState.new(0, preload("res://Objects/coffee_can.tscn"))
	state1.addTransition(preload("res://Tools/CoffeeCan.tres").id, PStateTransition.new([2], [3.0], state1, true))
	
	states.append(state1)
	currentState = states[0]
	
	progress.value = 100
	sprite.frame = 0

## Called by the player's interactive area
func interact(player: PlayerController, object: Variant) -> void:
	if sprite.frame == 0:
		## turn on faucet
		sprite.frame = 1
	
		if object != null:
			var p = object.get_child(1)
			if p.texture == preload("res://assets/objects/EmptyWaterCan.png"):
				sprite.frame = 2
			
			## Make Can in player hand invisible
			object.visible = false
			object.reparent(get_tree().current_scene.get_node("Objects"))
			player.itemInHand = null
			object.freeze = false
			object.get_node("CollisionPolygon2D").disabled = false
			object.global_position = Vector2(100,530)
			#player.Hand.remove_child(object)
			
			## Create new Sprite with Can and water and show it
			progress.visible = true
			var transitionIN:Tween = get_tree().create_tween()
			transitionIN.tween_property(progress,"value",0,worktime)
			audioStream.play(0)
			player.canMove = false
			await get_tree().create_timer(worktime).timeout
			player.canMove = true
			transitionIN.kill()
			progress.visible = false
			progress.value = 100
			object.visible = true
			audioStream.stop()
			
			## Modify Can in player hand
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				if p.texture == preload("res://assets/Objects/WaterCan.png") or p.texture == preload("res://assets/Objects/CoffeCan.png") or  p.texture == preload("res://assets/Objects/CoffeCan-juice-banana.png")  :
					p.texture = preload("res://assets/objects/EmptyWaterCan.png")
				else:
					p.texture = preload("res://assets/Objects/WaterCan.png")
		
		else:
			progress.visible = true
			var transitionIN:Tween = get_tree().create_tween()
			transitionIN.tween_property(progress,"value",0,worktime)
			await get_tree().create_timer(worktime).timeout
			transitionIN.kill()
			progress.visible = false
			progress.value = 100
		
		sprite.frame = 0
