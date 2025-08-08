extends Node

var scn_menu := preload("res://scenes/scn_menu.tscn")
var scn_level := preload("res://scenes/scn_level.tscn")

var scn_menu_instance: Node = null
var scn_level_instance: Node = null
var screen_size = DisplayServer.screen_get_size()


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	init_win()
	open_menu()
	open_level()
	

func _process(delta: float) -> void:
	pass


func  init_win() -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_mouse_passthrough(PackedVector2Array([Vector2(0, 0)]), false)
	DisplayServer.window_set_position(Vector2i(0, 0))
	DisplayServer.window_set_size(screen_size)
	pass
	

func open_menu() -> void:
	if scn_menu_instance: return
	
	scn_menu_instance = scn_menu.instantiate()
	add_child(scn_menu_instance)
	
	
func open_level() -> void:
	if scn_level_instance: return
	
	scn_level_instance = scn_level.instantiate()
	add_child(scn_level_instance)
	
