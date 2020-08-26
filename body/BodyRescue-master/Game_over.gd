extends Node

var player = {
"score":0,
"level":0,
"lives":3
}

func _ready():
	$Loose_prev.visible=true
	$Publicidad.visible=true
	$Continue.visible=true
	Global.load_game()
	player=Global.player

func _on_Continue_pressed():
	Global.save_game(0,-1,3)
	get_tree().change_scene("res://Mundo.tscn")


func _on_Publicidad_pressed():
	Global.save_game(player.score,player.level+1,1)
	get_tree().change_scene("res://Level"+str(player.level+1)+".tscn")
