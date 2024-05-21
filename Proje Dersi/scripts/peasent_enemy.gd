extends Node2D

var curve_2d:Curve2D
var peasent_progress:float = 0
var peasent_speed:float = 100
var peasent_heal:int = 100

func _ready():
	curve_2d = Curve2D.new()
	for element in PathGenInstance.get_path_reversed():
		curve_2d.add_point(Vector2(element.x*48+24, element.y*48+23)) 
	$Path2D.curve = curve_2d
	$Path2D/PathFollow2D.progress_ratio = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _on_spawning_state_entered():
	$AnimationPlayer.play("spawning")
	await $AnimationPlayer.animation_finished
	$EnemyStateChart.send_event("to_travelling") # Replace with function body.

func _on_travelling_state_entered():
	pass

func _on_travelling_state_processing(delta):
	peasent_progress += delta * peasent_speed
	$Path2D/PathFollow2D.progress = peasent_progress
	if peasent_heal <= 0:
		print("peasent died")
		$EnemyStateChart.send_event("to_dying")
	if peasent_progress >= PathGenInstance.get_path_route().size()*46+24:
		print("reached")
		$EnemyStateChart.send_event("to_despawning")


func _on_despawning_state_entered():
	$AnimationPlayer.play("despawning") # Replace with function body.
	await $AnimationPlayer.animation_finished
	queue_free()


func _on_dying_state_entered():
	$AnimationPlayer.play("dying") # Replace with function body.
	await $AnimationPlayer.animation_finished
	queue_free() # Replace with function body.
