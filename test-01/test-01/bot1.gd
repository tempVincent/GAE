extends CharacterBody2D

@export var player:CharacterBody2D
@export var speed = 150
var musicPlayer:AudioStreamPlayer2D 

var canmove = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $"../../Player"
	$AnimatedSprite2D.play("default")
	musicPlayer = $"../../AudioStreamPlayer2D"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canmove:
		var target_pos = player.position
		velocity = target_pos - self.position
		
		move_and_slide()
		
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i).get_collider()
			
			
			if collision == $"../../Player":
				$"../../Player".damage()
				self.queue_free()
	


func death():
	canmove = false
	$AnimatedSprite2D.play("death")
	#$AnimatedSprite2D.z_index = 1
	musicPlayer.stream = load("res://kenney_desert-shooter-pack_1/Sounds/hurt-c.ogg")
	musicPlayer.play()
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(3).timeout
	$AnimatedSprite2D.visible = false
	
	#$CPUParticles2D.emitting =true
	await get_tree().create_timer(1).timeout
	queue_free()
	pass
