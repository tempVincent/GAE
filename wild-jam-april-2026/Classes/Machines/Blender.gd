class_name Blender extends Processor

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# sprite.texture
	
	# var stateOneStart: ProcessState = ProcessState.new().initialize(empty, "")
	# var stateTwoVariantOneBananaBlending: ProcessState = ProcessState.new().initialize(bananaBlend, "")
	# var stateTwoVariantTwoChilliBlending: ProcessState = ProcessState.new().initialize(chilliBlend, "")
	# var stateThreeHasVariantOneBananaDone: ProcessState = ProcessState.new().initialize(bananaSmooth, "res://prefabs/portables/banana_smoothie.tscn")
	# var stateThreeHasVariantOneChilliDone: ProcessState = ProcessState.new().initialize(chilliSmooth, "res://prefabs/portables/chilli_smoothie.tscn")
	
	# stateOneStart.setTransition("Banana", stateTwoVariantOneBananaBlending)
	# stateOneStart.setTransition("Chilli", stateTwoVariantTwoChilliBlending)
	# stateTwoVariantOneBananaBlending.setAutoTransition(stateThreeHasVariantOneBananaDone, 3) # need to find a way to combine auto transition with product return
	# stateTwoVariantTwoChilliBlending.setAutoTransition(stateThreeHasVariantOneChilliDone, 3) # need to find a way to combine auto transition with product return
	# stateThreeHasVariantOneBananaDone.setAutoTransition(stateOneStart, 1)
	# stateThreeHasVariantOneChilliDone.setAutoTransition(stateOneStart, 1)
	
	# states = [stateOneStart]
	# currentState = stateOneStart
	pass
