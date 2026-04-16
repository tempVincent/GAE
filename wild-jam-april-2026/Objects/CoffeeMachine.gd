extends Processor

@onready var sprite:Sprite2D = $Sprite2D

func interact(player:CharacterBody2D, object:Node2D) -> void:	
		if object != null:
			##POSITION
			##Make Can invisible
			object.visible = false
			player.canMove = false
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans.png")
			
			await get_tree().create_timer(2.5).timeout
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans_filled.png")
			
			##Disable movement of player
			##Create new SPrite with Can and water and show it
			await get_tree().create_timer(2.5).timeout
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans NoCan.png")
			
			##Make can visible
			object.visible = true
			player.canMove = true
			
			if object.scene_file_path == "res://Objects/coffeeCan.tscn":
				var p = object.get_child(1)
				p.texture = preload("res://assets/Objects/CoffeCan.png")
		else:
			await get_tree().create_timer(5.0).timeout
