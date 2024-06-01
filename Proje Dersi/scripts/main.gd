extends Node2D

@export var tile_straight:PackedScene
@export var tile_empty:Array[PackedScene]
@export var tile_corner:PackedScene
@export var peasent_enemy:PackedScene
@export var knight_enemy:PackedScene
#var path_config:pathgeneratorconfig = preload("res://Resource/basic_path_config.res")
@onready var cam = $Camera2D

var RAYCAST_LENGTH:float = 100

func _ready():
	$SolTarafProje/Banka1.visible = true
	$SolTarafProje/Carpentryy.visible = true
	$Control/Button.disabled = true
	$Control/Button.self_modulate = Color(1,1,1,0)
	_complete_grid()
	print(PathGenInstance.get_path_route())
	print(PathGenInstance.get_path_reversed())

	await get_tree().create_timer(0.5).timeout
	_summon_peasant()
	await get_tree().create_timer(1).timeout
	_summon_knight()
	
func _summon_peasant():
	for i in 3:
		await get_tree().create_timer(2).timeout
		var box = peasent_enemy.instantiate()
		add_child(box)
		
func _summon_knight():
	for i in 0:
		await get_tree().create_timer(2).timeout
		var box = knight_enemy.instantiate()
		add_child(box)	
		
func _physics_process(_delta):
	if Input.is_action_just_released("mouse_left") and not $Control/Button._is_dragging:
		var space_state = get_world_2d().direct_space_state
		var mouse_pos:Vector2 = get_viewport().get_mouse_position()
		var origin:Vector2 = Vector2(mouse_pos.x-320,mouse_pos.y)
		var end:Vector2 = Vector2(mouse_pos.x-320,mouse_pos.y)
		var query = PhysicsRayQueryParameters2D.create(origin, end)
		query.collide_with_areas = true
		query.hit_from_inside = true
		var rayResult:Dictionary = space_state.intersect_ray(query)
		var co:CollisionObject2D = rayResult.get("collider")
		if rayResult.size() > 0:
			if co.get_groups()[0] == "empty":
				$SolTarafProje/Banka1.visible = false
				$SolTarafProje/Carpentryy.visible = false
				$Control/Button.disabled = false
				$Control/Button.self_modulate = Color(1,1,1,1)
			else:
				$SolTarafProje/Banka1.visible = true
				$SolTarafProje/Carpentryy.visible = true
				$Control/Button.disabled = true
				$Control/Button.self_modulate = Color(1,1,1,0)
		else:
			$SolTarafProje/Banka1.visible = true
			$SolTarafProje/Carpentryy.visible = true
			$Control/Button.disabled = true
			$Control/Button.self_modulate = Color(1,1,1,0)

func _complete_grid():
	for x in range(PathGenInstance.path_config.map_lenght):
		for y in range (PathGenInstance.path_config.map_height+7):
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
			tile_rotation = 0
		elif tile_score == 8:
			tile = tile_straight.instantiate()
			tile_rotation = 0
		elif tile_score == 10:
			tile = tile_straight.instantiate()
			tile_rotation = 0
		elif tile_score == 1 or tile_score == 4 or tile_score == 5:
			tile = tile_straight.instantiate()
			tile_rotation = 90
		elif tile_score == 6:
			tile = tile_corner.instantiate()
			tile_rotation = 0
		elif tile_score == 12:
			tile = tile_corner.instantiate()
			tile_rotation = 90
		elif tile_score == 9:
			tile = tile_corner.instantiate()
			tile_rotation = 180
		elif tile_score == 3:
			tile = tile_corner.instantiate()
			tile_rotation = -90
			
		add_child(tile)
		tile.global_position = Vector2(PathGenInstance.get_path_tile(i).x*48+24, PathGenInstance.get_path_tile(i).y*48+24)
		tile.global_rotation_degrees = tile_rotation

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print(event.position)
		#print("Mouse Click/Unclick at: ", (int(event.position.x-36)/48)-6,",", int(event.position.y)/48)
