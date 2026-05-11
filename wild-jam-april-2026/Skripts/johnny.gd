extends Node2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D2
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound2
@onready var jhonny: Node2D = $"."

func _ready():
	ObjectivePool.player_lost.connect(_explode)
	pass

func _explode():
	print("Called")
	explosion_sound.play()
	gpu_particles_2d.position = jhonny.global_position
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true
	await get_tree().create_timer(1.0).timeout
	jhonny.visible = false
	await get_tree().create_timer(2.0).timeout
	queue_free()
	get_tree().change_scene_to_file("res://gameEndMenu.tscn")
