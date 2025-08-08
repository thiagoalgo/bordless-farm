extends Node

var scn_menu := preload("res://scenes/scn_menu.tscn")
var scn_level := preload("res://scenes/scn_level.tscn")

var scn_menu_instance: Node  = null
var scn_level_instance: Node = null
var screen_size: Vector2i    = DisplayServer.screen_get_size()


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	init_win()
	open_menu()
	#open_level()


func  init_win() -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func open_menu() -> void:
	if scn_menu_instance: return
	
	DisplayServer.window_set_position((screen_size - get_window().size) / 2)
	scn_menu_instance = scn_menu.instantiate()
	scn_menu_instance.button_play_pressed.connect(_on_menu_button_play_pressed)
	add_child(scn_menu_instance)


func open_level() -> void:
	if scn_level_instance: return
	
	scn_level_instance = scn_level.instantiate()
	scn_level_instance.setup(scn_level_instance.GameWindowSide.NORTH, 0, 70)
	DisplayServer.window_set_position(scn_level_instance.map.pos)
	DisplayServer.window_set_size(scn_level_instance.map.size)
	add_child(scn_level_instance)


func _on_menu_button_play_pressed():
	scn_menu_instance.queue_free()
	open_level()
