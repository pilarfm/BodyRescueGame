extends Node

const SAVE_PATH = "user://saves.sav"
var bactKill=0
var nave
var activo=true
var analogico = Vector2(0,0)

var player = {
"score":0,
"level":0,
"lives":3,
"record":0
}

func new_bacteria_kill():
	bactKill+=1

func new_game():
	bactKill=0

func actualizarRecord(r):
	if (r > player.record):
		player.record=r

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
	#return player

func setNave(n):
	nave=n

func set_activo(cond):
	activo=cond

func getNave():
	return nave
