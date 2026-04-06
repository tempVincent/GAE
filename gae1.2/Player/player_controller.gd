extends CharacterBody2D

var tile_size = 16
var inputs = { "d": Vector2.RIGHT,
			   "a": Vector2.LEFT,
			   "w": Vector2.UP,
			   "s": Vector2.DOWN }
var current_input

var animations = { "d": "right",
			   "a": "left",
			   "w": "up",
			   "s": "down" }

var particlesList = { "d": Vector2(-10,0),
			   "a": Vector2(10,0),
			   "w": Vector2(0,10),
			   "s": Vector2(0, -10) }


@onready var ray = $RayCast2D
@onready var interactives = $"../Interactives"
@onready var NotificationIcon = $NotificationIcon
@onready var infoarea = $"../CanvasLayer/BoxContainer"
@onready var infotext = $"../CanvasLayer/BoxContainer/NinePatchRect/RichTextLabel"
@onready var particles = $CPUParticles2D

var is_walking = false
var animation_speed = 4


func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2


#Input Handler
func _process(_delta: float) -> void:
	if is_walking:
		return

	for dir in inputs.keys():
		animation_speed =4
		if Input.is_action_pressed(dir):
			if Input.is_action_pressed("sprint"):
				animation_speed = 6
				
				#region particles
				particles.position = particlesList[dir]
				particles.visible = true
			
			else:
				particles.visible = false
				#endregion
			
			
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
