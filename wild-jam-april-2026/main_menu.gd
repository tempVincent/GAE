extends Node2D

@onready var settings= $"/root/GlobalVars"
@onready var musicplayer = $AudioStreamPlayer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("MainMenu")
	settings.musicVol = 100
	musicplayer.playing = true
	var increaseVol:Tween = get_tree().create_tween()
	increaseVol.tween_property(musicplayer,"volume_db",-80 + (settings.musicVol * 0.8),1.5).set_trans(Tween.TRANS_QUAD)
	await increaseVol.finished
	increaseVol.kill()
	print("done")
	print(musicplayer.volume_db)
	
	
	$HBoxContainer2/AspectRatioContainer/VBoxContainer/AspectRatioContainer/GridContainer/HSlider.volChanged.connect(changeVol.bind())
	
	pass # Replace with function body.

func changeVol() -> void:
	
	var increaseVol:Tween = get_tree().create_tween()
	increaseVol.tween_property(musicplayer,"volume_db",-80 + (settings.musicVol * 0.8),1.5).set_trans(Tween.TRANS_QUAD)
	await increaseVol.finished
	increaseVol.kill()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
