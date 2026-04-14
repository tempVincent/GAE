extends StaticBody2D

@onready var idle:CompressedTexture2D = preload("res://assets/Objects/Water/idle.png")
@onready var active:CompressedTexture2D = preload("res://assets/Objects/Water/active.png")
@onready var filling:CompressedTexture2D = preload("res://assets/Objects/Water/filling.png")
@onready var sprite:Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = idle

func interact(player:CharacterBody2D, object:Node2D) -> void:
	if sprite.texture == idle:
		sprite.texture = active
		
		if object != null:
			##POSITION
			##Create new SPrite with Can and water and show it
			sprite.texture = filling
			
			##Make Can invisible
			object.visible = false
			
			##Disable movement of player
			player.canMove = false
			
			await get_tree().create_timer(5.0).timeout
			
			##make can visible
			object.visible = true
			player.canMove = true
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				var p = object.get_child(1)
				p.texture = preload("res://assets/Objects/WaterCan.png")
		else:
			await get_tree().create_timer(5.0).timeout
		sprite.texture = idle
