class_name FruitKillzone extends Area2D

@onready var objects: Node2D = $"../../Objects"

## 
func _ready() -> void:
	area_entered.connect(on_body_entered)

## 
func on_body_entered(banana: Area2D) -> void:
	#maybe free falling bananas should be children of objects, not of their spawnpoints...
	banana.get_parent().get_parent().remove_child(banana.get_parent())
	banana.get_parent().free()
