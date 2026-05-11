extends Area2D
var coffee_can
var inRangeObjects:Array
@onready var player = $"../../AudioStreamPlayer"
@onready var animated_sprite_2d: AnimatedSprite2D = $".."
@onready var gpu_particles_2d: GPUParticles2D = $"../GPUParticles2D"
	
## override base class listener called by the engine when another body moves into this area's detection mask
func _on_body_entered(body: Node2D):
	var path = body.get_path()
	print(path)
	if str(path) == "/root/WorkInProgress/Objects/CoffeeCan":
		var empty_tex = preload("res://assets/Objects/EmptyWaterCan.png")
		var p = body.get_child(1)
		print(p.texture)
		if p.texture == preload("res://assets/Objects/WaterCan.png")	:
			print("Texture" + str(p.texture))		
			if ObjectivePool.current_objective == ObjectivePool.objectives.water:
				print("Objective completed")
				player.play()
				ObjectivePool._complete_current_objective()
				p.texture = empty_tex
			
		if p.texture == preload("res://assets/Objects/CoffeCan.png")	:		
			if ObjectivePool.current_objective == ObjectivePool.objectives.coffee:
				print("Objective completed")
				player.play()
				#tasseFX.emitting = true
				p.texture = empty_tex
				ObjectivePool._complete_current_objective()
				await get_tree().create_timer(5).timeout
				#tasseFX.emitting = false

		if p.texture == preload("res://assets/Objects/CoffeCan-juice-banana.png"):		
			if ObjectivePool.current_objective == ObjectivePool.objectives.juice:
				print("Objective completed")
				player.play()
				ObjectivePool._complete_current_objective()
				p.texture = empty_tex

	elif body.scene_file_path == "res://Objects/Fruit.tscn":
			if ObjectivePool.current_objective == ObjectivePool.objectives.banana:
				print("Objective completed")
				player.play()
				ObjectivePool._complete_current_objective()
				body.free()
	
	elif str(path) == "/root/WorkInProgress/Objects/Water":
		if ObjectivePool.current_objective == ObjectivePool.objectives.water:
			print("Objective completed")
			player.play()
			ObjectivePool._complete_current_objective()
		print("i see: CoffeMachine")
	else:
		print("Johnny sieht:" + str(body.get_path()))
