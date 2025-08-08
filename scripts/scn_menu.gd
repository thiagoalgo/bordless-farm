extends Control

signal button_play_pressed

@onready var button_play: Button = $ButtonPlay


func _ready() -> void:
	button_play.pressed.connect(func(): emit_signal("button_play_pressed"))
