extends Area2D


var velocity
var speed = 300
var dir
var gun
const enemietype = preload("res://bot.tscn")
var musicPlayer:AudioStreamPlayer2D 
   
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun = $"../Player/Gun"
	dir = $"../Player".global_position.direction_to(get_global_mouse_position())
	self.position = gun.global_position
	musicPlayer = $"../AudioStreamPlayer2D"
	musicPlayer.stream = load("res://kenney_desert-shooter-pack_1/Sounds/shoot-d.ogg")
	musicPlayer.play()
	pass
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += dir * speed * delta
	pass

func _on_body_entered(body: Node) -> void:
	print("bullet hit")
	if body.is_in_group("enemie"):
		body.death()
		#body.queue_free()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	self.queue_free() # Replace with function body.
