extends Object
class_name PathGenerator

var _grid_lenght:int
var _grid_height:int

var _path: Array[Vector2i]

func _init(lenght:int,height:int):
	_grid_lenght = lenght
	_grid_height = height

func generate_path():
	_path.clear()
	
	var x = 0
	var y = int(_grid_height/2)
	
	while x < _grid_lenght-1:
			
		var newy:int = randi_range(5,9)
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
