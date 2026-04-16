extends Processor

@onready var sprite: Sprite2D = $Sprite2D
@onready var empty: CompressedTexture2D = preload("res://assets/objects/coffeeMachine/CoffeMachineEmpty.png")
@onready var beans: CompressedTexture2D = preload("res://assets/objects/coffeeMachine/CoffeeMachineBeans.png")
@onready var water: CompressedTexture2D = preload("res://assets/objects/coffeeMachine/CoffeMachineWaterCarafe.png")
@onready var filled: CompressedTexture2D = preload("res://assets/objects/coffeeMachine/CoffeeMachineFilled.png")
@onready var brewed: CompressedTexture2D = preload("res://assets/objects/coffeeMachine/CoffeMachineBrewed.png")

func _ready() -> void:
	sprite.texture = empty
	
	var stateOneStart: ProcessState = ProcessState.new().initialize(empty, "res://prefabs/objects/coffeeCan.tscn")
	var stateTwoVariantOneHasBeans: ProcessState = ProcessState.new().initialize(beans, "")
	var stateTwoVariantTwoHasWater: ProcessState = ProcessState.new().initialize(water, "")
	var stateThreeHasBeansHasWater: ProcessState = ProcessState.new().initialize(filled, "")
	var stateFourHasCoffee: ProcessState = ProcessState.new().initialize(brewed, "")
	
	stateOneStart.setTransition("Beans", stateTwoVariantOneHasBeans)
	stateOneStart.setTransition("WaterCarafe", stateTwoVariantTwoHasWater)
	stateTwoVariantOneHasBeans.setTransition("WaterCarafe", stateThreeHasBeansHasWater)
	stateTwoVariantTwoHasWater.setTransition("Beans", stateThreeHasBeansHasWater)
	stateThreeHasBeansHasWater.setAutoTransition(stateFourHasCoffee,5)
	stateThreeHasBeansHasWater.setAutoTransition(stateOneStart,1)
	
	states = [stateOneStart, stateTwoVariantOneHasBeans, stateTwoVariantTwoHasWater, stateThreeHasBeansHasWater, stateFourHasCoffee]
	currentState = stateOneStart
