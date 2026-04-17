class_name Sink extends Processor

@onready var sprite: Sprite2D = $Sprite2D
@onready var idle: CompressedTexture2D = preload("res://assets/objects/sink/idle.png")
@onready var running: CompressedTexture2D = preload("res://assets/objects/sink/running.png")
@onready var filling: CompressedTexture2D = preload("res://assets/objects/sink/filling.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = idle
	
	var stateOneStart: ProcessState = ProcessState.new().initialize(idle, "res://prefabs/portables/water_carafe.tscn")
	var stateTwoWaterRunning: ProcessState = ProcessState.new().initialize(running, "")
	var stateThreeFillingCarafe: ProcessState = ProcessState.new().initialize(filling, "")
	var stateFourWaterRunning: ProcessState = ProcessState.new().initialize(running, "")
	
	stateOneStart.setTransition("EmptyCarafe", stateTwoWaterRunning)
	stateTwoWaterRunning.setAutoTransition(stateThreeFillingCarafe, 1)
	stateThreeFillingCarafe.setAutoTransition(stateFourWaterRunning, 1)
	stateFourWaterRunning.setAutoTransition(stateOneStart, 1)
	
	states = [stateOneStart, stateTwoWaterRunning, stateThreeFillingCarafe, stateFourWaterRunning]
	currentState = stateOneStart
	
	self.stateChanged.connect(updateSprite)

func updateSprite() -> void:
	sprite.texture = currentState.texture
