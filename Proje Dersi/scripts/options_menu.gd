extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/Zorluklar/Kolay.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kolay_pressed():
	Resources.secilenzorluk = "kolay"


func _on_orta_pressed():
	Resources.secilenzorluk = "orta"


func _on_zor_pressed():
	Resources.secilenzorluk = "zor"



func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
