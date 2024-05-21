extends Object
class_name PathGenerator

var _grid_lenght:int
var _grid_height:int

var _path: Array[Vector2i]
var _path_reverse: Array[Vector2i]

func _init(lenght:int,height:int):
	_grid_lenght = lenght
	_grid_height = height

func generate_path():
	_path.clear()
	
	var x = 0
	var y = 0
	
	while x < _grid_lenght-1:
			
		var newy:int = randi_range(7.5-_grid_height/2, 7.5+_grid_height/2)
		if x == 0:
			y = newy
			_path.append(Vector2i(x,y))
		if x % 2 == 0:
			x += 1
			_path.append(Vector2i(x,y))
		elif x % 2 == 1:
			while newy > y:
				y += 1
				_path.append(Vector2i(x,y))
			while newy < y:
				y -= 1
				_path.append(Vector2i(x,y))
			if newy == y:
				x +=1
				_path.append(Vector2i(x,y))
		
			
	return _path

func get_tile_score(tile:Vector2i):
	var score:int = 0
	var x = tile.x
	var y = tile.y
	
	score += 1 if _path.has(Vector2i(x,y-1)) else 0
	score += 2 if _path.has(Vector2i(x+1,y)) else 0
	score += 4 if _path.has(Vector2i(x,y+1)) else 0
	score += 8 if _path.has(Vector2i(x-1,y)) else 0
	
	return score
	
func get_path() -> Array[Vector2i]:
	return _path

func get_path_reversed() -> Array[Vector2i]:
	var i:int= _path.size()-1
	for element in _path:
		_path_reverse.append(_path[i])
		i-=1
	print(_path_reverse)
	return _path_reverse

