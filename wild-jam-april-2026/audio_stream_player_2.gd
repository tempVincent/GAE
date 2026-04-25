extends AudioStreamPlayer


@onready var musicplayer = self
@onready var settings= $"/root/GlobalVars"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicplayer.playing = true
	
	var increaseVol:Tween = get_tree().create_tween()
	print(settings.musicVol)
	if settings.musicVol != 0:
		increaseVol.tween_property(musicplayer,"volume_db",-80 + (15*pow(settings.musicVol,0.37)),1.5).set_trans(Tween.TRANS_QUAD)
	else:
		increaseVol.tween_property(musicplayer,"volume_db",-10,1.5).set_trans(Tween.TRANS_QUAD)
	await increaseVol.finished
	increaseVol.kill()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
