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

var setup_done: bool = false
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


func setup(side: GameWindowSide = GameWindowSide.EAST, 
		margin_top: int = 0, 
		margin_botton: int = 70
) -> void:
	map.side = side
	map.margin.top = margin_top
	map.margin.bottom = margin_botton
	
	if map.side == GameWindowSide.NORTH or map.side == GameWindowSide.SOUTH:
		map.orientation = GameWindowOrientation.HORIZONTAL

	setup_done = true

	
func _init() -> void:
	calc_win_size()
	calc_win_pos()


func _ready() -> void:
	assert(setup_done, "Call setup() before using this class.")
	generate_map()
	create_map()
	
	
func calc_win_size() -> void:
	if map.orientation == GameWindowOrientation.VERTICAL:
		# EAST OR WEST
		map.size.x = int(screen_size.x * 0.15) # 15% da largura da tela
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
			# EAST
			map.pos.x = screen_size.x - map.size.x
		
		map.pos.y = 0 + map.margin.top
	else:
		if map.side == GameWindowSide.NORTH: 
			map.pos.x = 0
			map.pos.y = 0 + map.margin.top
		else:
			map.pos.x = 0
			map.pos.y = screen_size.y - map.size.y - map.margin.bottom

func create_map() -> void:
	#position = map.pos
	position = Vector2i.ZERO


func generate_map() -> void:
	var cols = ceil(map.size.x / TILE_WIDTH)
	var rows = ceil(map.size.y / TILE_HEIGHT)
	
	for x in range(cols):
		for y in range(rows):
			var pos: Vector2i = Vector2i(x, y)
			tilemap.set_cells_terrain_connect([pos], 0, 0)
