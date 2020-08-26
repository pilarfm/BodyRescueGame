extends Node

const SAVE_PATH = "user://saves.sav"

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func save_game(score,level,lives):
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	player.score=score
	player.level=level
	player.lives=lives
	save_game.store_line(to_json(player))
	save_game.close()
	

func load_game():
	var save_game = File.new()
	if (!save_game.file_exists(SAVE_PATH)):
		return # Error! No hay archivo que guardar
	save_game.open(SAVE_PATH, File.READ)
	player = parse_json(save_game.get_line())
	save_game.close()
	return player
