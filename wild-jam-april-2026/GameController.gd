extends Node2D

@onready var musicplayer = $BaseComponents/AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicplayer.playing = true
	var increaseVol:Tween = get_tree().create_tween()
	increaseVol.tween_property(musicplayer,"volume_db",-5,1.5).set_trans(Tween.TRANS_QUAD)
	await increaseVol.finished
	increaseVol.kill()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
