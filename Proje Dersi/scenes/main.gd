extends Node2D

@export var path_tile:PackedScene
@export var empty_tile1:PackedScene
@export var map_lenght:int = 20
@export var map_height:int = 8

#naber yorum deneme
var map_grid: Array[Vector2i]
var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	_pg = PathGenerator.new(map_lenght, map_height)
	create_grid()
	_display_map()
	
func _display_map():
	var path:Array[Vector2i] = _pg.generate_path()
	print(path)
	var empty_area:Array[Vector2i]
	for element in map_grid:
		if element not in path:
			empty_area.append(element)
	for element in path:
		var tile:Node2D = path_tile.instantiate()
		add_child(tile)
		tile.global_position = Vector2(element.x*48,element.y*48)
	for element in empty_area:
		var tile:Node2D = empty_tile1.instantiate()
		add_child(tile)
		tile.global_position = Vector2(element.x*48,element.y*48)
		
func create_grid():
	for x in range (0,20):
		for y in range (0,15):
			map_grid.append(Vector2i(x,y))

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Mouse Click/Unclick at: ", event.position)
