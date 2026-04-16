class_name FruitSpawner extends Node2D

var spawnBranches: Array
var spawnCooldown: float = 2 #seconds
var fruits: Array = []
var fruit = preload("res://Objects/Fruit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().connect("ready", _start)
	spawnBranches = find_children("spawnBranch"+"?", "Node2D", true, false)

# Called once after the root node in the scene tree is ready.
func _start() -> void:
	StartSpawning()

func StartSpawning() -> void:
	for branch in spawnBranches:
		var timer = branch.get_node("Timer")
		timer.timeout.connect(spawnAt.bind(branch.get_node("spawnpoint")))
		timer.timeout.connect(timer.start.bind(spawnCooldown))
		timer.start(spawnCooldown)

func spawnAt(parent: Node2D) -> void:
	parent.add_child(fruit.instantiate())
	#print("fruit spawned")
