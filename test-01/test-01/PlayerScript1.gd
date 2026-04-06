extends CharacterBody2D


@export var speed = 200
@export var hp = 50
var gun = preload("res://gun.tscn")
var firstgun

func _ready() -> void:
	firstgun = $Gun
	pass

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if direction.x <0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x >0:
		$AnimatedSprite2D.flip_h = false
	
	if direction.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	direction = direction.normalized()
	velocity = direction * speed

	move_and_slide()


func damage():
	hp -= 1
	$HPbar2/HPbar.points[1].x =hp/2
	print(hp)

func upgrade():
	self.scale += Vector2(0.1,0.1)
	var newgun = gun.instantiate()
	newgun.offset = firstgun.offset + Vector2(5,5)
	
	add_child(newgun)
	


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
