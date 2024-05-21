extends Node
class_name PathGenerator

var path_config:pathgeneratorconfig = preload("res://Resource/basic_path_config.res")



var zorluk_tablosu = {"kolay":45, "orta":35 , "zor":25  } 

var _path_route: Array[Vector2i]
var _path_reverse: Array[Vector2i]


func _init():
	generate_path()
	while _path_route.size() <  zorluk_tablosu[path_config.zorluk] or _path_route.size() > zorluk_tablosu[path_config.zorluk ] + 10:
		generate_path()

func generate_path():
	_path_route.clear()
	randomize()
	
	var x = 0
	var y = 0
	
	while x < path_config.map_lenght-1:
			
		var newy:int = randi_range(7.5-path_config.map_lenght/2, 7.5+path_config.map_height/2)
		if x == 0:
			y = newy
			_path_route.append(Vector2i(x,y))
		if x % 2 == 0:
			x += 1
			_path_route.append(Vector2i(x,y))
		elif x % 2 == 1:
			while newy > y:
				y += 1
				_path_route.append(Vector2i(x,y))
			while newy < y:
				y -= 1
				_path_route.append(Vector2i(x,y))
			if newy == y:
				x +=1
				_path_route.append(Vector2i(x,y))
		
			
	return _path_route

func get_tile_score(index:int) -> int:
	var score:int = 0
	var x = _path_route[index].x
	var y = _path_route[index].y
	
#    1
# 8    2
#    4
	score += 1 if _path_route.has(Vector2i(x,y-1)) else 0
	score += 2 if _path_route.has(Vector2i(x+1,y)) else 0
	score += 4 if _path_route.has(Vector2i(x,y+1)) else 0
	score += 8 if _path_route.has(Vector2i(x-1,y)) else 0
	
	return score
	
func get_path_route() -> Array[Vector2i]:
	return _path_route

func get_path_tile(index:int) -> Vector2i:
	return _path_route[index]



func get_path_reversed() -> Array[Vector2i]:
	var i:int= _path_route.size()-1
	for element in _path_route:
		_path_reverse.append(_path_route[i])
		i-=1
	print(_path_reverse)
	return _path_reverse

