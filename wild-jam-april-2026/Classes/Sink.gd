extends Processor

@onready var sprite: Sprite2D = $Sprite2D
@onready var idle: CompressedTexture2D = preload("res://assets/Objects/sink/idle.png")
@onready var running: CompressedTexture2D = preload("res://assets/Objects/sink/running.png")
@onready var filling: CompressedTexture2D = preload("res://assets/Objects/sink/filling.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = idle
	
	var stateOneStart: ProcessState = ProcessState.new().initialize(idle, "")
	var stateTwoWaterRunning: ProcessState = ProcessState.new().initialize(running, "")
	var stateThreeFillingCarafe: ProcessState = ProcessState.new().initialize(filling, "")
	var stateFourWaterRunning: ProcessState = ProcessState.new().initialize(running, "res://Prefabs/WaterCarafe.tscn")
	
	stateOneStart.setTransition("Carafe", stateTwoWaterRunning)
	stateTwoWaterRunning.setAutoTransition(stateThreeFillingCarafe, 1)
	stateThreeFillingCarafe.setAutoTransition(stateFourWaterRunning, 5)
	stateFourWaterRunning.setAutoTransition(stateOneStart, 1)
	
	states = [stateOneStart, stateTwoWaterRunning, stateThreeFillingCarafe, stateFourWaterRunning]
	currentState = stateOneStart
