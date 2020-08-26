extends Node

export (PackedScene) var Bacteria
signal hide_bacteria
signal start_HUD1
signal hide_HUD

var deleteBacteria =false

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	Global.set_activo(true)
	$Start.show()
	$TimerReady.start()
	emit_signal("hide_HUD")

func _on_TimerReady_timeout():
	$Start.hide()
	emit_signal("start_HUD1")
	#$Interfaz.update_score(Score)
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	$InicioTimer.start()
	$Nave.show()
	$background.show()
	$HUD_game.actualizarScore(0)
	Global.load_game()
	player=Global.player
	$HUD_game.actualizarVidas(player.lives)
	$sound.play()

func game_over():
	Global.set_activo(false)
	$BacteriaTimer.stop()
	deleteBacteria=true
	emit_signal("hide_bacteria")
	$ScoreTimer.stop()
	emit_signal("hide_HUD")
	player.score= 0
	$LevelLoose.visible=true
	$Again.disabled=false
	$Again.visible=true
	if(player.lives<=1):
		get_tree().change_scene("res://Game_over.tscn")
	else:
		Global.save_game(player.score,player.level,player.lives-1)
	
func _on_NextScene_timeout():
	get_tree().change_scene("res://body.tscn")

func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()
	$LevelTimer.start()
	
func _on_LevelTimer_timeout():	#Gana el nivel
	Global.set_activo(false)
	$BacteriaTimer.stop()
	$ScoreTimer.stop()
	emit_signal("hide_HUD")
	$LevelWin.visible=true
	Global.save_game(player.score,player.level+1,player.lives)
	$NextScene.start()

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())
	var B = Bacteria.instance()
	#var aux=get_node(B)
	B.change_bacteria_type(["grande1","chica1"])
	B.select_animation(randi() % B.tipo_bacteria.size())
	#aux.select_animation(randi() % tipo_bacteria.size())
	#$AnimatedSprite.animation= tipo_bacteria[randi() % tipo_bacteria.size()]
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))
	

func play_again():
	get_tree().change_scene("res://Level1.tscn")

func _on_ScoreTimer_timeout():
	player.score += 1
	$HUD_game.actualizarScore(player.score)
