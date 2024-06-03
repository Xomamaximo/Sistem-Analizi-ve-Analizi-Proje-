extends Button
@export var activity_button_icon:Texture2D
@export var activity_draggable:PackedScene

var _is_dragging: bool = false
var _draggable: Node
var _is_valid_location:bool =false
var _last_valid_location:Vector2
var _cam: Camera2D

func _ready():
	icon = activity_button_icon
	_draggable = activity_draggable.instantiate()
	_draggable.set_patrolling(false)
	_draggable.top_level = true
	disable_collision(_draggable)
	add_child(_draggable)
	_cam = get_viewport().get_camera_2d()
	_draggable.visible = false

func _physics_process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and _is_dragging:
		var space_state = get_world_2d().direct_space_state
		var mouse_pos:Vector2 = get_viewport().get_mouse_position()
		var origin:Vector2 = Vector2(mouse_pos.x-320,mouse_pos.y)
		var end:Vector2 = Vector2(mouse_pos.x-330,mouse_pos.y)
		var query = PhysicsRayQueryParameters2D.create(origin, end)
		query.collide_with_areas = true
		query.hit_from_inside = true
		var rayResult:Dictionary = space_state.intersect_ray(query)
		if rayResult.size() > 0:
			#print(rayResult)
			var co:CollisionObject2D = rayResult.get("collider")
			if co.get_groups().has("tower"):
				_draggable.visible = true
				_draggable.global_position = Vector2(co.global_position)
				_is_valid_location = false
				find_and_set_sprite_color(_draggable,Color(2.5,1,1,1))
			elif co.get_groups()[0] == "empty":
				#print(co.get_groups())
				_draggable.visible = true
				_is_valid_location = true
				_last_valid_location = Vector2(co.global_position)
				_draggable.global_position = _last_valid_location
				find_and_set_sprite_color(_draggable,Color(1,1,1,1))
			else:
				_draggable.visible = true
				_draggable.global_position = Vector2(co.global_position)
				_is_valid_location = false
				find_and_set_sprite_color(_draggable,Color(2.5,1,1,1))
		else:
			_draggable.visible = false

func find_and_set_sprite_color (n:Node,renk):
	for c in n.get_children():
		if c is Sprite2D:
			set_sprite_color(c,renk)
		if c is Node and c.get_child_count() > 0:
			find_and_set_sprite_color(c,renk)

func disable_collision(n:Node):
	for c in n.get_children():
		if c is Area2D:
			for f in c.get_children():
				if f is CollisionShape2D:
					f.disabled = true


func set_sprite_color (sprite_2d:Sprite2D,renk):
	sprite_2d.modulate = Color(renk)
	


func _on_button_down():
	print("button down")
	_is_dragging = true


func _on_button_up():
	print("button up")
	_is_dragging = false
	_draggable.visible = false
	
	if _is_valid_location:
		var activity = activity_draggable.instantiate()
		add_child(activity)
		activity.global_position = _last_valid_location
