class_name Johnny extends Consumer

var desiredBeverages: Array[String] = ["Coffee","WaterCarafe","FruitSmoothie"]
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	chooseNextDesire = chooseBeverageAtRandom
	desiredBeverageName = chooseBeverageAtRandom.call()
	beverageContainerPackedScene = load("res://prefabs/portables/empty_carafe.tscn")

func chooseBeverageAtRandom() -> String:
	return desiredBeverages[rng.randi_range(0, desiredBeverages.size()-1)]
