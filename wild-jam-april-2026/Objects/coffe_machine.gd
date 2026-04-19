extends StaticBody2D

@onready var sprite:Sprite2D = $Sprite2D
@onready var progress:ProgressBar = $ProgressBar
var worktime = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress.value = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact(player:CharacterBody2D, object:Node2D) -> void:	
		if object != null:
			##POSITION
			object.visible = false
			player.canMove = false
			progress.visible = true
			var transitionIN:Tween = get_tree().create_tween()
			transitionIN.tween_property(progress,"value",0,worktime)
			
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans.png")
			##Make Can invisible
			await get_tree().create_timer(worktime/2).timeout
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans_filled.png")
			##Disable movement of player
			##Create new SPrite with Can and water and show it
			await get_tree().create_timer(worktime/2).timeout
			sprite.texture = preload("res://assets/Objects/CoffeMachine beans NoCan.png")
			
			transitionIN.kill()
			progress.visible = false
			progress.value = 100
			
			player.canMove = true
			object.visible = true
			##make can visible
			
			
			if object.scene_file_path == "res://Objects/coffee_can.tscn":
				var p = object.get_child(1)
				p.texture = preload("res://assets/Objects/CoffeCan.png")
				
				pass
		else:
			await get_tree().create_timer(5.0).timeout
