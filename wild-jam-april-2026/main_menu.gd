extends Node2D

@onready var settings= $"/root/GlobalVars"
@onready var musicplayer = $AudioStreamPlayer2
@onready var master_bus_index = AudioServer.get_bus_index("Master")

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("MainMenu")
	settings.musicVol = 100
	musicplayer.playing = true
	var increaseVol:Tween = get_tree().create_tween()
	increaseVol.tween_property(musicplayer,"volume_db",-80 + (15*pow(settings.musicVol,0.37)),1).set_trans(Tween.TRANS_QUAD)
	await increaseVol.finished
	increaseVol.kill()
	print("done")
	print(musicplayer.volume_db)
	$HBoxContainer2/AspectRatioContainer/VBoxContainer/AspectRatioContainer/GridContainer/HSlider.volChanged.connect(changeVol.bind())

## 
func changeVol() -> void:
	#musicplayer.volume_db = -80 + (15*pow(settings.musicVol,0.37))
	AudioServer.set_bus_volume_db(master_bus_index,-80 + (15*pow(settings.musicVol,0.37)))
