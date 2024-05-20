extends Node2D

@export var tile_straight:PackedScene
@export var tile_empty:PackedScene
@export var tile_corner:PackedScene
@export var map_lenght:int = 20
@export var map_height:int = 8

@export_enum("kolay", "orta", "zor" ) var zorluk: String
var zorluk_tablosu = {"kolay":50, "orta":35 , "zor":26  }

var map_grid: Array[Vector2i]
var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	_pg = PathGenerator.new(map_lenght, map_height)
	_display_path()
	_complete_grid()
	
func _complete_grid():
	for x in range(map_lenght):
		for y in range (15):
			if not _pg.get_path().has(Vector2i(x,y)):
				var tile:Node2D = tile_empty.instantiate()
				add_child(tile)
				tile.global_position = Vector2(x*48+24,y*48+24)
func _display_path():
	var _path:Array[Vector2i] = _pg.generate_path()
	
	while _path.size() >= zorluk_tablosu[zorluk]:
		_path = _pg.generate_path()
	print(_path)

	for element in _path:
		var tile_score:int = _pg.get_tile_score(element)
		
		var tile:Node2D = tile_empty.instantiate()
		var tile_rotation:float = 0
		
		if tile_score == 2 or tile_score == 8 or tile_score == 10:
			tile = tile_straight.instantiate()
			tile_rotation = 0
		elif tile_score == 1 or tile_score == 4 or tile_score == 5:
			tile = tile_straight.instantiate()
			tile_rotation = 90
		elif tile_score == 12:
			tile = tile_corner.instantiate()
			tile_rotation = 90
		elif tile_score == 6:
			tile = tile_corner.instantiate()
			tile_rotation = 0
		elif tile_score == 9:
			tile = tile_corner.instantiate()
			tile_rotation = 180
		elif tile_score == 3:
			tile = tile_corner.instantiate()
			tile_rotation = 270
		add_child(tile)
		tile.global_position = Vector2(element.x*48+24,element.y*48+24)
		tile.global_rotation_degrees = tile_rotation

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(event.position)
		print("Mouse Click/Unclick at: ", (int(event.position.x-36)/48)-6,",", int(event.position.y)/48)
