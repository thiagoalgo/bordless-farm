extends Control

signal button_play_pressed
signal option_button_side_item_selected

@onready var button_play: Button = $VBoxContainer/ButtonPlay
@onready var option_button_side: OptionButton = $VBoxContainer/OptionButtonSide


func _ready() -> void:
	button_play.pressed.connect(func(): emit_signal("button_play_pressed"))
	option_button_side.item_selected.connect(
		func(side: int): emit_signal("option_button_side_item_selected", side)
	)
