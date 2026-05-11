extends Node2D

var obj_text = ObjectivePool.get_objective_text(ObjectivePool.current_objective)

@onready var label = $Label
@onready var water = $Water
@onready var juice = $Juice
@onready var coffee = $Coffee
@onready var banane = $Banane

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ObjectivePool.objectives_updated.connect(update_speech)
	update_speech()

## 
func update_speech():
	var transition:Tween = get_tree().create_tween()
	transition.tween_property(self, "scale", Vector2(0,0), 1).set_trans(Tween.TRANS_QUAD)
	await transition.finished
	transition.kill()
	
	var obj_text = ObjectivePool.get_objective_text(ObjectivePool.current_objective)
	#label.text = "I need " + obj_text
	
	water.visible = false
	juice.visible = false
	coffee.visible = false
	banane.visible = false
	
	match obj_text:
		"coffee":
			coffee.visible = true
		"banana":
			banane.visible = true
		"juice":
			juice.visible = true
		"water":
			water.visible = true
	
	var transitionIN: Tween = get_tree().create_tween()
	transitionIN.tween_property(self, "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_QUAD)
	await transitionIN.finished
	transitionIN.kill()
