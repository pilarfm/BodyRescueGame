extends Node

export (PackedScene) var Body
var Score
#onready var save = load("res://Saves.gd").new()

var player = {
"score":0,
"level":0,
"lives":3
}

#func _ready():
#	randomize()

func _on_Interfaz_iniciar_juego():
	if(!load_game()):
		Global.save_game(0,-1,3)
	get_tree().change_scene_to(Body)

func load_game():
	var exist=true
	var save_game = File.new()
	if(not save_game.file_exists(Global.SAVE_PATH)):
		exist=false
	save_game.close()
	return exist
