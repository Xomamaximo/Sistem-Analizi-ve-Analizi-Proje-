extends Area2D
class_name ProjectileArrow

var starting_position:Vector2
var target:Node2D

@export var speed:float = 1.5
@export var damage:int = 20
var lerp_pos:float = 0

func _ready():
	global_position = starting_position

func _process(delta):
	if target != null and lerp_pos < 0.95:
		global_position = starting_position.lerp(target.global_position, lerp_pos)
		lerp_pos += delta * speed
		$".".look_at(target.global_position)
	else:
		queue_free()
