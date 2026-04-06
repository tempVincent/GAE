extends Timer


@export var botsFolder:Node2D
var rng = RandomNumberGenerator.new()
var bot = preload("res://bot.tscn")
var upgrade = preload("res://upgrade.tscn")
var usedcellse
var bordercells
var spawnablecells


func _ready() -> void:
	usedcellse = $"../../Floor".get_used_cells()
	bordercells = $"../../Border".get_used_cells()
	spawnablecells = usedcellse.filter(func(x): return not bordercells.has(x))

func _on_timer_timeout():
	var rngamount = rng.randf_range(1,3)
	var rngUpgrade = rng.randf_range(1,2)
	
	for i in range(rngamount):
		var newBot = bot.instantiate()
		var newposition = randi() % usedcellse.size()
		var transform = $"../../Floor".map_to_local(usedcellse[newposition])
		newBot.position = transform
		get_parent().add_child(newBot)
	if rngUpgrade ==1:
		var newUpgrade = upgrade.instantiate()
		var newUpgradePos = randi() % usedcellse.size()
		newUpgrade.position = $"../../Floor".map_to_local(usedcellse[newUpgradePos])
		get_parent().add_child(newUpgrade)
	pass
