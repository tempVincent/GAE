extends Processor

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
var juice = false
@onready var progress:ProgressBar = $ProgressBar
var worktime = 3
var shortworktime = 1
var fruitsCollected:int = 0
@onready var label_fruitsCollected:Label = $Label
var newFont = load("res://assets/Fonts/SuperMaples-2vR2w.ttf")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress.value = 100
	label_fruitsCollected.add_theme_font_override("myFont", newFont)

func interact(player: PlayerController, object: Node2D = null, carriedObjectData: Carryable = null) -> void:
		if object != null:
			print("Mixer wird ausgeführt mit: " + object.scene_file_path)
			
			if object.scene_file_path == "res://Objects/Fruit.tscn":
				fruitsCollected += 1
				label_fruitsCollected.text = str(fruitsCollected) + "/3"
				
				if fruitsCollected == 3:
					object.visible = false
					sprite.play("default")
					label_fruitsCollected.visible = false
					progress.visible = true
					var transitionIN:Tween = get_tree().create_tween()
					transitionIN.tween_property(progress,"value",0,worktime)
					
					await get_tree().create_timer(worktime).timeout
					transitionIN.kill()
					progress.visible = false
					progress.value = 100
					
					sprite.stop()
					sprite.frame = 5
					juice = true
					
					fruitsCollected = 0
					
				object.get_parent().remove_child(object)
				player.itemInHand = null
				
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				if juice == true:
					object.visible = false
					var items = get_tree().current_scene.get_node("Objects")
					object.reparent(items)
					player.itemInHand = null
					object.freeze = false

					var collision = object.get_node("CollisionPolygon2D")
					collision.disabled = false
					object.global_position = Vector2(400,600)
					object.isInHand = false
					player.Hand.remove_child(object)
					sprite.frame = 0
					
					progress.visible = true
					var transitionIN:Tween = get_tree().create_tween()
					transitionIN.tween_property(progress,"value",0,shortworktime)
					
					await get_tree().create_timer(shortworktime).timeout
					transitionIN.kill()
					progress.visible = false
					progress.value = 100
					
					var p = object.get_child(1)
					p.texture = preload("res://assets/Objects/CoffeCan-juice-banana.png")
					
					player.canMove = true
					object.visible = true
					label_fruitsCollected.visible = true
					juice = false
					#fruitsCollected = 0
					label_fruitsCollected.text =  str(fruitsCollected) + "/3"
					
				
		else:
			await get_tree().create_timer(5.0).timeout
