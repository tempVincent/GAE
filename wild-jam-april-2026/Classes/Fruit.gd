class_name Fruit extends Carryable

var defaultTexture: CompressedTexture2D = preload("res://icon.svg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = data.displayTexture
	if sprite.texture == null:
		sprite.texture = defaultTexture
	var transitionIN:Tween = get_tree().create_tween()
	transitionIN.tween_property(self, "scale", Vector2(1,1), 0.5)
	await transitionIN.finished
	transitionIN.kill()
	self.gravity_scale = 1

func _enter_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		characterAnimation = get_parent().get_parent()
		
		##Set Params
		freeze = true
		position = Vector2(0, 0)
		collision.disabled = true
		#scale = Vector2(0.5, 0.5)
		rotation = 0

func _exit_tree() -> void:
	if get_parent().get_parent().get_parent().scene_file_path == "res://Player/silvester.tscn":
		
		##Cleanup Params
		freeze = false
		collision.disabled = false
		#scale = Vector2(1, 1)
