extends Area2D
var coffee_can
var inRangeObjects:Array
@onready var tasseFX = $"../../../Funiture/Tasse/CPUParticles2D"

func _on_body_entered(body: Node2D):
	var path = body.get_path()
	print(path)
	if str(path) == "/root/WorkInProgress/Objects/CoffeeCan":
		var empty_tex = preload("res://Assets/objects/carafe/EmptyCarafe.png")
		var p = body.get_child(1)
		if p.texture == preload("res://Assets/objects/carafe/WaterCarafe.png")	:		
			if ObjectivePool.current_objective == ObjectivePool.objectives.water:
				print("Objective completed")
				ObjectivePool._complete_current_objective()
				p.texture = empty_tex
		if p.texture == preload("res://Assets/objects/carafe/CoffeeCarafe.png")	:		
			if ObjectivePool.current_objective == ObjectivePool.objectives.coffee:
				print("Objective completed")
				
				tasseFX.emitting = true
				await get_tree().create_timer(5).timeout
				tasseFX.emitting = false
				
				p.texture = empty_tex
				ObjectivePool._complete_current_objective()
				
	#elif str(path) == "/root/WorkInProgress/Objects/Fruits":
		#if ObjectivePool.current_objective == ObjectivePool.objectives.fruits:
		#	print("Objective completed")
		#	ObjectivePool._complete_current_objective()
					
	elif str(path) == "/root/WorkInProgress/Objects/Sink":
		if ObjectivePool.current_objective == ObjectivePool.objectives.water:
			print("Objective completed")
			ObjectivePool._complete_current_objective()
		print("i see: CoffeMachine")
	else:
		print("Johnny sieht:" + str(body.get_path()))
