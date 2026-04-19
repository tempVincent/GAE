extends AudioStreamPlayer

@onready var musicplayer = self
@onready var settings= $"/root/GlobalVars"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var increaseVol:Tween = get_tree().create_tween()
	increaseVol.tween_property(musicplayer,"volume_db",-80 + (settings.musicVol * 0.55),1.5).set_trans(Tween.TRANS_QUAD)
	await increaseVol.finished
	increaseVol.kill()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
