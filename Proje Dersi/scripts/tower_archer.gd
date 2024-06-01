extends Node2D

var enemies_in_range: Array[Node2D]
var current_enemy:Node2D = null
var current_enemy_targeted:bool = false
var acquire_slerp_progress: float = 0

func _process(delta):
	if current_enemy_targeted:
		$Shooter.look_at(current_enemy.global_position)
	elif current_enemy != null:
		rotate_towards_target(current_enemy, delta)

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
	var target_vector = $Shooter.global_position.direction_to(rtarget.global_position)
	$Shooter.look_at($Shooter.global_position.slerp(target_vector, 1))
	print($Shooter.global_position.slerp(target_vector, acquire_slerp_progress))
	acquire_slerp_progress += delta * 2
	
	if acquire_slerp_progress > 0:
		current_enemy_targeted = true
	if acquire_slerp_progress < 1:
		current_enemy_targeted = false
