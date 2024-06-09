extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	Resources.start_new_round = false
	Resources.round_ended = false
	Resources.round_end_reward_given = true
	Resources.peasent_total = 2
	Resources.knight_total = 1
	Resources.peasent_left = Resources.peasent_total
	Resources.knight_left = Resources.knight_total
	Resources.game_round = 0
	Resources.game_health = 1
	Resources.gold = 0
	Resources.wood = 4
	Resources.stone = 2
	Resources.iron = 0
	Resources.in_game = true
	PathGenInstance.zorluk_ayarla()
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
