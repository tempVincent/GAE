class_name FruitSpawner extends Node2D

var spawnBranches: Array
var spawnCooldownMin: float = 1 #seconds
var spawnCooldownMax: float = 10 #seconds
var rng = RandomNumberGenerator.new()
var fruits: Array[PackedScene] = []
@onready var Objects = $"../Objects"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().get_root().ready.connect(_start)
	spawnBranches = find_children("spawnBranch"+"?", "Node2D", true, false)
	fruits.append(preload("res://Objects/Fruit.tscn"))
	StartSpawning()

# Called once after the root node in the scene tree is ready.
func _start() -> void:
	StartSpawning()

func StartSpawning() -> void:
	for branch in spawnBranches:
		var timer = branch.get_node("Timer")
		if timer.is_class("Timer"):
			timer.timeout.connect(spawnAt.bind(branch.get_node("spawnpoint")))
			timer.timeout.connect(timer.start.bind(rng.randf_range(spawnCooldownMin,spawnCooldownMax)))
			timer.timeout.connect(randomize)
			timer.start(rng.randf_range(spawnCooldownMin,spawnCooldownMax))

func spawnAt(parent: Node2D) -> void:
	var fruit = fruits[rng.randi_range(0,fruits.size()-1)].instantiate()
	fruit.global_position = parent.global_position
	Objects.add_child(fruit)
