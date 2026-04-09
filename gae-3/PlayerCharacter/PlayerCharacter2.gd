extends RigidBody2D

@export var engine_thrust = 1500
@export var spin_thrust = 15000

var thrust = Vector2()
var move = Vector2()
var running = false
var Speed = 10
var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size

func get_input():
	if Input.is_action_just_pressed("space"):
		engine_thrust = -1 * engine_thrust
	if Input.is_action_pressed("ui_up"):
		thrust = transform.y * engine_thrust
	else:
		thrust = Vector2(0,-1* (engine_thrust/2))
	if Input.is_action_pressed("ui_right"):
		move.x = Speed

func _process(delta):
	get_input()

func _physics_process(delta):
	apply_force(thrust)
	move_and_collide(move)
