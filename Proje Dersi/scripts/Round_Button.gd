extends Button



func _ready():
	text = str(Resources.game_round+1,".Turu Başlat")



func _process(_delta):
<<<<<<< Updated upstream
	text = str("BAŞLA\nTur:",Resources.game_round)
=======
	if Resources.round_ended:
		text = str(Resources.game_round+1,".Turu Başlat")
	if not Resources.round_ended and Resources.game_round != 0:
		text = str("Tur: ",Resources.game_round)
>>>>>>> Stashed changes
	if Resources.peasent_left + Resources.knight_left == 0 and Resources.round_ended == false:
		Resources.round_ended = true
		Resources.round_end_reward_given = false
		print("round ended")
	if Resources.round_end_reward_given == false and not Resources.game_round == 0:
		Resources.gold += 20 * Resources.gold_multiplier
		if Resources.game_round % 1 == 0 :
			Resources.wood += 1
		if Resources.game_round % 2 == 0 :
			Resources.stone += 1
		if Resources.game_round % 3 == 0 :
			Resources.iron += 1
		Resources.round_end_reward_given = true
		print("rewards given")


func _on_button_down():
	if Resources.peasent_left + Resources.knight_left == 0 or Resources.game_round == 0:
		Resources.peasent_total = int(ceil((Resources.game_round+0.5) ** 1.5))
		Resources.knight_total = int(ceil(Resources.game_round ** 0.5))
		print(Resources.peasent_total)
		print(Resources.knight_total)
		print("round started")
		Resources.peasent_left =Resources.peasent_total
		Resources.knight_left = Resources.knight_total
		Resources.round_ended = false
		Resources.start_new_round = true
		Resources.game_round += 1 
