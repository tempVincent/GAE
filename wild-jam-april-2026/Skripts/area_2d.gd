extends Area2D
var coffee_can
var inRangeObjects:Array
@onready var tasseFX = $"../../../Funiture/Tasse/CPUParticles2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D):
	var path = body.get_path()
	print(path)
	print(body)
	if str(path) == "/root/WorkInProgress/Objects/CoffeeCan":
		var empty_tex = preload("res://assets/Objects/EmptyWaterCan.png")
		var p = body.get_child(1)
		print(p)
		if p.texture == preload("res://assets/Objects/WaterCan.png")	:		
			if ObjectivePool.current_objective == ObjectivePool.objectives.water:
				print("Objective completed")
				ObjectivePool._complete_current_objective()
				p.texture = empty_tex
		if p.texture == preload("res://assets/Objects/CoffeCan.png")	:		
			if ObjectivePool.current_objective == ObjectivePool.objectives.coffee:
				print("Objective completed")
				
				tasseFX.emitting = true
				await get_tree().create_timer(5).timeout
				tasseFX.emitting = false

				p.texture = empty_tex
				ObjectivePool._complete_current_objective()
		if p.texture == preload("res://assets/objects/CoffeCan-juice-banana.png"):		
			if ObjectivePool.current_objective == ObjectivePool.objectives.juice:
				print("Objective completed")
				ObjectivePool._complete_current_objective()
				p.texture = empty_tex

	elif body.get_class() == "Fruit" :
		if ObjectivePool.current_objective == ObjectivePool.objectives.banana:
			print("Objective completed")
			ObjectivePool._complete_current_objective()
					
	elif str(path) == "/root/WorkInProgress/Objects/Water":
		if ObjectivePool.current_objective == ObjectivePool.objectives.water:
			print("Objective completed")
			ObjectivePool._complete_current_objective()
		print("i see: CoffeMachine")
	else:
		print("Johnny sieht:" + str(body.get_path()))
