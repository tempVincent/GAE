extends StaticBody2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
var fruit = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact(player:CharacterBody2D, object:Node2D) -> void:	
		if object != null:
			print("Mixer wird ausgeführt mit: " + object.scene_file_path)
			
			if object.scene_file_path == "res://objects/fruit.tscn":
				object.visible = false
				sprite.play("default")
				##Make Can invisible
				player.canMove = false
				await get_tree().create_timer(5).timeout
				player.canMove = true
				sprite.stop()
				sprite.frame = 5
				object.get_parent().remove_child(object)
				fruit = true
				player.itemInHand = null
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				if fruit == true:
					player.canMove = false
					object.visible = false
					sprite.frame = 0
					
					await get_tree().create_timer(1).timeout
					
					var p = object.get_child(1)
					p.texture = preload("res://assets/Objects/CoffeCan-juice-banana.png")
					
					player.canMove = true
					object.visible = true
					
					fruit = false
					
				
		else:
			await get_tree().create_timer(5.0).timeout
