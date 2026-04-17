class_name FruitSpawner extends Node2D

var spawnBranches: Array
var spawnCooldownMin: float = 5 #seconds
var spawnCooldownMax: float = 20 #seconds
var rng = RandomNumberGenerator.new()
var fruits: Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().ready.connect(_start)
	spawnBranches = find_children("spawnBranch"+"?", "Node2D", true, false)
	fruits.append(preload("res://prefabs/portables/banana.tscn"))

# Called once after the root node in the scene tree is ready.
func _start() -> void:
	StartSpawning()

func StartSpawning() -> void:
	for branch in spawnBranches:
		var timer = branch.get_node("Timer")
		if timer.is_class("Timer"):
			timer.timeout.connect(spawnAt.bind(branch.get_node("spawnpoint")))
			timer.timeout.connect(timer.start.bind(rng.randi_range(spawnCooldownMin,spawnCooldownMax)))
			timer.timeout.connect(randomize)
			timer.start(rng.randi_range(spawnCooldownMin,spawnCooldownMax))

func spawnAt(parent: Node2D) -> void:
	var fruit: Ingredient = fruits[rng.randi_range(0,fruits.size()-1)].instantiate()
	parent.add_child(fruit)
	
	#var despawnTimer: Timer = Timer.new()
	#despawnTimer.timeout.connect(func () -> void:
	#	parent.remove_child(fruit)
	#	fruit.queue_free()
	#)
	#fruit.add_child(despawnTimer)
	#despawnTimer.start(10)
