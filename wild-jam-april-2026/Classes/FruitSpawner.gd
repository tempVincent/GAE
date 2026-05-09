class_name FruitSpawner extends Node2D

var spawnBranches: Array[Node]
var spawnCooldownMin: float = 1.0 #seconds
var spawnCooldownMax: float = 10.0 #seconds
var fruit: PackedScene = preload("res://Objects/Fruit.tscn")
var fruitsData: Array[Ingredient] = [preload("res://Fruits/banana.tres"), preload("res://Fruits/chilli.tres")]
@onready var Objects = $"../Objects"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnBranches = find_children("spawnBranch"+"?", "Node2D", true, false)
	StartSpawning()

func StartSpawning() -> void:
	for branch in spawnBranches:
		var timer = branch.get_node("Timer")
		assert(timer.is_class("Timer"), "Timer is not a Timer")
		timer.timeout.connect(spawn.bind(fruit, fruitsData[randi_range(0,fruitsData.size()-1)], branch.get_node("spawnpoint")))
		timer.timeout.connect(startRandomTimer.bind(timer))
		startRandomTimer(timer)

func StopSpawning() -> void:
	for branch in spawnBranches:
		var timer = branch.get_node("Timer")
		assert(timer.is_class("Timer"), "Timer is not a Timer")
		timer.timeout.disconnect(spawn)
		timer.timeout.disconnect(timer.start)
		timer.stop()

func startRandomTimer(timer: Timer) -> void:
	randomize()
	timer.start(randf_range(spawnCooldownMin,spawnCooldownMax))

func spawn(obj: PackedScene, objData: Resource, parent: Node2D) -> void:
	var instance = obj.instantiate()
	instance.data = objData
	instance.global_position = parent.global_position
	Objects.add_child(instance)
