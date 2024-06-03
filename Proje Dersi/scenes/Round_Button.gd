extends Button



func _ready():
	pass # Replace with function body.



func _process(delta):
	text = str("Tur: ",Resources.game_round)	



func _on_button_down():
	if Resources.peasent_left + Resources.knight_left == 0 or Resources.game_round == 0:
		Resources.game_round += 1
		Resources.new_round = true
		Resources.peasent_left = Resources.peasent_total
		Resources.knight_left = Resources.knight_total
		print(Resources.new_round)
