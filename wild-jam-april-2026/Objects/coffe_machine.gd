extends StaticBody2D

@onready var sprite:Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact(player:CharacterBody2D, object:Node2D) -> void:	
		if object != null:
			##POSITION
			object.visible = false
			player.canMove = false
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans.png")
			##Make Can invisible
			await get_tree().create_timer(2.5).timeout
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans_filled.png")
			##Disable movement of player
			##Create new SPrite with Can and water and show it
			await get_tree().create_timer(2.5).timeout
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans NoCan.png")
			
			player.canMove = true
			object.visible = true
			##make can visible
			
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				var p = object.get_child(1)
				p.texture = preload("res://assets/Objects/CoffeCan.png")
				
				pass
		else:
			await get_tree().create_timer(5.0).timeout
