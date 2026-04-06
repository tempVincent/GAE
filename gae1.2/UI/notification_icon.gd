extends Sprite2D
@onready var t = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	t.wait_time = 2.0
	t.one_shot =true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visibility_changed() -> void:
	if visible == true:
		t.start(2)
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	visible = false
	pass # Replace with function body.
