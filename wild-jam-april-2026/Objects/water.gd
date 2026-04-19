extends StaticBody2D

@onready var idle:CompressedTexture2D = preload("res://assets/Objects/Water/idle.png")
@onready var active:CompressedTexture2D = preload("res://assets/Objects/Water/active.png")
@onready var filling:CompressedTexture2D = preload("res://assets/Objects/Water/filling.png")
@onready var sprite:Sprite2D = $Sprite2D
@onready var progress:ProgressBar = $ProgressBar
var worktime = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = idle
	progress.value = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func interact(player:CharacterBody2D, object:Node2D) -> void:
	if sprite.texture == idle:
		sprite.texture = active
		
	
		if object != null:
			##POSITION
			sprite.texture = filling
			object.visible = false
			player.canMove = false
			##Make Can invisible
			##Disable movement of player
			##Create new SPrite with Can and water and show it
			progress.visible = true
			var transitionIN:Tween = get_tree().create_tween()
			transitionIN.tween_property(progress,"value",0,worktime)
			
			await get_tree().create_timer(worktime).timeout
			transitionIN.kill()
			progress.visible = false
			progress.value = 100
			
			player.canMove = true
			object.visible = true
			##make can visible
			
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				var p = object.get_child(1)
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
		sprite.texture = idle
	pass
