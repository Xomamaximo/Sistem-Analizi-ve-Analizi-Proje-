extends Label



func _ready():
	pass # Replace with function body.



func _process(_delta):
	text = str("Altın: ",Resources.gold,"      Odun: ",Resources.wood,"      Taş: ",Resources.stone,"      Demir: ",Resources.iron,"       Kalan Düşman Sayısı: ",Resources.peasent_left+Resources.knight_left)
