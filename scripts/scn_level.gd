extends Node2D

const TILE_WIDTH: int  = 16
const TILE_HEIGHT: int = 16

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

var screen_size: Vector2i = DisplayServer.screen_get_size()

var map: Dictionary = {
	"size": Vector2i.ZERO,
	"pos": Vector2i.ZERO,
	"margin": {
		"top": 40,
		"bottom": 40,
	},
	"side": GameWindowSide.NORTH,
	"orientation": GameWindowOrientation.VERTICAL
}

@onready var tilemap := $TileMapLayer


func _init() -> void:
	#### For Test
	#map.side = GameWindowSide.SOUTH
	#map.side = GameWindowSide.NORTH
	map.side = GameWindowSide.EAST
	#map.side = GameWindowSide.WEST
	
	map.margin.top = 0
	map.margin.bottom = 70
	####
	
	if map.side == GameWindowSide.NORTH or map.side == GameWindowSide.SOUTH:
		map.orientation = GameWindowOrientation.HORIZONTAL


func _ready() -> void:
	calc_win_size()
	generate_map()
	calc_win_pos()
	create_map()
	
	
func calc_win_size() -> void:
	if map.orientation == GameWindowOrientation.VERTICAL:
		# EAST OR WEST
		map.size.x = int(screen_size.x * 0.10) # 15% da largura da tela
		map.size.y = int(screen_size.y) - map.margin.top - map.margin.bottom # altura da tela
	else:
		# NORTH OR SOUTH
		map.size.x = int(screen_size.x) # largura da tela
		map.size.y = int(screen_size.y * 0.20) + TILE_HEIGHT # 20% da altura da tela
		

func calc_win_pos() -> void:
	if map.orientation == GameWindowOrientation.VERTICAL:
		if map.side == GameWindowSide.WEST: 
			map.pos.x = 0
		else:
			# East
			# Ajusta a posição para colar no lado, porque tem o arredondamento do tamanho da tela
			# em relação ao tamanho da multiplicação dos tiles
			map.pos.x = screen_size.x - map.size.x + (map.size.x - get_map_used_size().x)
		
		map.pos.y = 0 + map.margin.top
	else:
		if map.side == GameWindowSide.NORTH: 
			map.pos.x = 0
			map.pos.y = 0 + map.margin.top
		else:
			map.pos.x = 0
			map.pos.y = screen_size.y - map.size.y - map.margin.bottom

func create_map() -> void:
	position = map.pos
	print(position)


func generate_map() -> void:
	var cols = ceil(map.size.x / TILE_WIDTH)
	var rows = ceil(map.size.y / TILE_HEIGHT)
	
	for x in range(cols):
		for y in range(rows):
			var pos: Vector2i = Vector2i(x, y)
			tilemap.set_cells_terrain_connect([pos], 0, 0)
			

func get_map_used_size() -> Vector2:
	var used_rect = tilemap.get_used_rect() # em coordenadas de tile
	var cell_size = tilemap.tile_set.tile_size # tamanho de cada tile em pixels (Vector2i)

	var pixel_size: Vector2 = Vector2(
		used_rect.size.x * cell_size.x,
		used_rect.size.y * cell_size.y
	)
	
	return pixel_size
