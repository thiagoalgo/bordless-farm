extends Control

signal button_play_pressed
signal option_button_side_item_selected

@onready var button_play: Button = $VBoxContainer/ButtonPlay
@onready var option_button_music: OptionButton = $VBoxContainer/OptionButtonMusic
@onready var hslider_music = $VBoxContainer/HSliderMusic
@onready var option_button_side: OptionButton = $VBoxContainer/OptionButtonSide
@onready var button_credits: Button = $VBoxContainer/ButtonCredits
@onready var button_credits_close: Button = $PanelCredits/VBoxContainer/ButtonClose
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var musics: Array = [
	"",
	"res://assets/musics/a_very_brady_special.mp3",
	"res://assets/musics/evening.mp3",
	"res://assets/musics/midnight_tale.mp3",
	"res://assets/musics/moonlight_beach.mp3",
	"res://assets/musics/morning.mp3",
]

var music: Dictionary = {
	"index": 0,
	"volume": 0.25
}

func _ready() -> void:
	hslider_music.value = music.volume
	
	button_play.pressed.connect(func(): emit_signal("button_play_pressed"))
	option_button_music.item_selected.connect(_on_option_button_music_item_selected)
	hslider_music.value_changed.connect(_on_hslider_music_value_changed)
	option_button_side.item_selected.connect(
		func(side: int): emit_signal("option_button_side_item_selected", side)
	)
	button_credits.pressed.connect(_on_button_credits_pressed)
	button_credits_close.pressed.connect(_on_button_credits_close_pressed)
	

func play_music() -> void:
	if music.index < 0 or music.index >= musics.size():
		return

	var music_path: String = musics[music.index]
	if music_path == "":
		audio_stream_player.stop()
	else:
		var stream: AudioStream = load(music_path)
		audio_stream_player.stream = stream
		audio_stream_player.volume_db = linear_to_db(music.volume)
		audio_stream_player.play()


func _on_option_button_music_item_selected(index: int) -> void:
	music.index = index
	play_music()


func _on_hslider_music_value_changed(value: float) -> void:
	music.volume = value
	audio_stream_player.volume_db = linear_to_db(music.volume)


func _on_button_credits_pressed() -> void:
	$PanelCredits.visible = true
	
	
func _on_button_credits_close_pressed() -> void:
	$PanelCredits.visible = false