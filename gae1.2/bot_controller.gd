extends CharacterBody2D

var tile_size = 16
var inputs = { 1: Vector2.RIGHT,
			   2: Vector2.LEFT,
			   3: Vector2.UP,
			   4: Vector2.DOWN }
var current_input

var animations = { 1: "right",
			   2: "left",
			   3: "up",
			   4: "down" }

var particlesList = { 1: Vector2(-10,0),
			   2: Vector2(10,0),
			   3: Vector2(0,10),
			   4: Vector2(0, -10) }


@onready var ray = $RayCast2D
@onready var interactives = $"../Interactives"
@onready var NotificationIcon = $NotificationIcon
@onready var infoarea = $"../CanvasLayer/BoxContainer"
@onready var infotext = $"../CanvasLayer/BoxContainer/NinePatchRect/RichTextLabel"
@onready var particles = $CPUParticles2D
@onready var movementTimer = $MovementTimer

var is_walking = false
var animation_speed = 4


func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2


#Input Handler
func controller(input: int) -> void:
	if is_walking:
		return
	
	for dir in inputs.keys():
		animation_speed =4
		if dir == input:

			move(dir)
			break

#region Movement
func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		animation(dir)
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir]* tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_QUAD)
		is_walking = true
		await tween.finished
		is_walking = false
	else:
		if is_interactive(dir):
			print("is interactive")
#endregion



func animation(dir):
	$AnimatedSprite2D.animation = animations[dir]
		

#region Interaction
func is_interactive(dir):
	var target_global = global_position + inputs[dir] * tile_size
	var target_local = interactives.to_local(target_global)
	var cell = interactives.local_to_map(target_local)
	
	var temp = interactives.get_cell_atlas_coords(cell)
	if interactives.get_cell_atlas_coords(cell) != Vector2i(-1, -1):
		if interactives.get_cell_atlas_coords(cell) == Vector2i(1,7) or Vector2i(2,7) or Vector2i(3,7):
			NotificationIcon.visible = true
			infoarea.visible = true
			infotext.set_deferred("text", "Oh die Türe ist zu. Vielleicht musst du später kommen?") 
			print("closed door")
		if interactives.get_cell_atlas_coords(cell) == Vector2i(2,6):
			print("open door")
		print("is interactive")
		return true
	
	print("not interactive")
	return false


#endregion


func _on_movement_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	var dir = rng.randf_range(1,4)
	controller(dir)
	movementTimer.start(5)
	
	
	pass # Replace with function body.
