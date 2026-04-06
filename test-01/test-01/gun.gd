extends Sprite2D

var bullet = preload("res://bullet.tscn")
var dir
var canshoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot") and canshoot :
		var newBullet = bullet.instantiate()
		
		get_parent().get_parent().add_child(newBullet)
		
		$Timer.start()
		canshoot = false


func _on_timer_timeout() -> void:
	canshoot = true
	pass # Replace with function body.
