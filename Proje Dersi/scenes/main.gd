extends Node2D

@export var tile_straight:PackedScene
@export var tile_empty:Array[PackedScene]
@export var tile_corner:PackedScene
@export var tile_enemy:PackedScene

var path_config:pathgeneratorconfig = preload("res://Resource/basic_path_config.res")

#var map_grid: Array[Vector2i]
#var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	#PathGenInstance = PathGenerator.new(map_lenght, map_height)
	_complete_grid()
	print(PathGenInstance.get_path_route())

	await get_tree().create_timer(0.5).timeout
	_pop_along_grid()
	
func _pop_along_grid():
	var box = tile_enemy.instantiate()
	
	var c2d:Curve2D = Curve2D.new()
	
	for element in PathGenInstance.get_path_reversed():
		var _aralık:int = 0
		while _aralık < 48:
			_aralık += 1
			c2d.add_point(Vector2(element.x*48+24, element.y*48+24))

	var p2d:Path2D = Path2D.new()
	add_child(p2d)
	p2d.curve = c2d
	
	var pf2d:PathFollow2D = PathFollow2D.new()
	p2d.add_child(pf2d)
	pf2d.add_child(box)
	
	var curr_distance:float = 0.0
	
	while curr_distance < c2d.point_count-1:
		curr_distance += 1
		pf2d.progress = clamp(curr_distance, 0, c2d.point_count-48.0001)
		await get_tree().create_timer(0.01).timeout

func _complete_grid():
	for x in range(path_config.map_lenght):
		for y in range (PathGenInstance.path_config.map_height):
			if not PathGenInstance.get_path_route().has(Vector2i(x,y)):
				var tile:Node2D = tile_empty.pick_random().instantiate()
				add_child(tile)
				tile.global_position = Vector2(x*48+24,y*48+24)
				tile.global_rotation_degrees = 90
				
	for i in range(PathGenInstance.get_path_route().size()):
		var tile_score:int = PathGenInstance.get_tile_score(i)
		
		var tile:Node2D = tile_empty[0].instantiate()
		var tile_rotation: float = 0
		
		if tile_score == 2:
			tile = tile_straight.instantiate()
			tile_rotation = -90
		elif tile_score == 8:
			tile = tile_straight.instantiate()
			tile_rotation = 90
		elif tile_score == 10:
			tile = tile_straight.instantiate()
			tile_rotation = 90
		elif tile_score == 1 or tile_score == 4 or tile_score == 5:
			tile = tile_straight.instantiate()
			tile_rotation = 0
		elif tile_score == 6:
			tile = tile_corner.instantiate()
			tile_rotation = 180
		elif tile_score == 12:
			tile = tile_corner.instantiate()
			tile_rotation = 90
		elif tile_score == 9:
			tile = tile_corner.instantiate()
			tile_rotation = 0
		elif tile_score == 3:
			tile = tile_corner.instantiate()
			tile_rotation = 270
			
		add_child(tile)
		tile.global_position = Vector2(50,50)
		tile.global_rotation_degrees = tile_rotation



func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(event.position)
		print("Mouse Click/Unclick at: ", (int(event.position.x-36)/48)-6,",", int(event.position.y)/48)
