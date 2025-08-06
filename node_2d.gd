extends Node2D

const TILE_WIDTH = 16
const TILE_HEIGHT = 16

enum GameWindowSide {
	NORTH, 
	SOUTH, 
	EAST,
	WEST
}

enum GameWindowOrientation {
	HORIZONTAL,
	VERTICAL
}

var screen_size = DisplayServer.screen_get_size()
var win_size = Vector2i.ZERO
var win_pos = Vector2i.ZERO
var win_margin_top = 40
var win_margin_bottom = 40
var win_side = GameWindowSide.NORTH
var win_orientation = GameWindowOrientation.VERTICAL

@onready var tilemap := $TileMapLayer


func _init() -> void:
	#### Para testes
	win_side = GameWindowSide.EAST
	####
	if win_side == GameWindowSide.NORTH or win_side == GameWindowSide.SOUTH:
		win_orientation = GameWindowOrientation.HORIZONTAL
		
	calc_win_size()
	calc_win_pos()
	create_window()


func _ready() -> void:
	
	generate_map()


func calc_win_size() -> void:
	if win_orientation == GameWindowOrientation.VERTICAL:
		win_size.x = int(screen_size.x * 0.15) # 15% da largura da tela
		win_size.y = int(screen_size.y) # altura da tela
	else:
		win_size.x = int(screen_size.x) # largura da tela
		win_size.y = int(screen_size.y * 0.2) # 20% da altura da tela
		

func calc_win_pos() -> void:
	if win_orientation == GameWindowOrientation.VERTICAL:
		if win_side == GameWindowSide.WEST: 
			win_pos.x = 0
			win_pos.y = 0
		else:
			win_pos.x = screen_size.x - win_size.x
			win_pos.y = 0
	else:
		if win_side == GameWindowSide.NORTH: 
			win_pos.x = 0
			win_pos.y = 0
		else:
			win_pos.x = 0
			win_pos.y = screen_size.y - win_size.y


func create_window() -> void:
	DisplayServer.window_set_size(win_size)
	DisplayServer.window_set_position(win_pos)


func generate_map() -> void:
	var cols = ceil(win_size.x / TILE_WIDTH)
	var rows = ceil(win_size.y / TILE_HEIGHT)
	
	for x in range(cols):
		for y in range(rows):
			var pos = Vector2i(x, y)
			tilemap.set_cells_terrain_connect([pos], 0, 0)
