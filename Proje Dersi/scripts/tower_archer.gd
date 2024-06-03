extends Node2D

var enemies_in_range: Array[Node2D]
var current_enemy:Node2D = null
var current_enemy_targeted:bool = false
var acquire_slerp_progress: float = 0
var last_fire_time:int

@export var fire_rate_ms:int = 1000
@export var projectile_type:PackedScene

func _on_patrol_zone_area_entered(area):
	print(area," entered")
	
	if current_enemy == null:
		current_enemy = area
	
	enemies_in_range.append(area)
	print(enemies_in_range.size())


func _on_patrol_zone_area_exited(area):
	print(area," exited")
	enemies_in_range.erase(area)
	print(enemies_in_range.size())

func set_patrolling(patrolling:bool):
	$PatrolZone.monitoring = patrolling

func rotate_towards_target(rtarget, delta):
	var target_vector:Vector2 = rtarget.global_position
	$Shooter.look_at($Shooter.global_position.slerp(target_vector, acquire_slerp_progress))
	acquire_slerp_progress += delta * 2
	
	if acquire_slerp_progress > 1:
		$StateChart.send_event("to_attacking")


func _on_patrolling_state_processing(_delta):
	if enemies_in_range.size() > 0:
		#current_enemy = enemies_in_range[enemies_in_range.size()-1]
		current_enemy = enemies_in_range[0]
		$StateChart.send_event("to_acquiring")


func _on_acquiring_state_entered():
	current_enemy_targeted = false
	acquire_slerp_progress = 0


func _on_acquiring_state_physics_processing(delta):
	if current_enemy!= null and enemies_in_range.has(current_enemy):
		$Shooter.look_at(current_enemy.global_position)
		rotate_towards_target(current_enemy,delta)
	else:
		print("enemy disappeared while acquiring")
		$StateChart.send_event("to_patrolling")
	


func _on_attacking_state_physics_processing(_delta):
	if current_enemy!= null and enemies_in_range.has(current_enemy):
		$Shooter.look_at(current_enemy.global_position)
		maybe_fire()
	else:
		print("enemy disappeared")
		$StateChart.send_event("to_patrolling")

func maybe_fire():
	if Time.get_ticks_msec() > (last_fire_time + fire_rate_ms):
		#print("Fire!!")
		var projectile:Projectile = projectile_type.instantiate()
		projectile.starting_position = $Shooter/projectile_spawn.global_position
		projectile.target = current_enemy
		add_child(projectile)
		last_fire_time = Time.get_ticks_msec()	

func _on_attacking_state_entered():
	#print("target acquieried")
	last_fire_time = 0
