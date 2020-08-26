extends Node

export (PackedScene) var Bacteria
export (PackedScene) var Antibody
export (PackedScene) var Bala_plus
export (int) var cantAntbodyMax
export (int) var cantBactMax
export (int) var cantBalasMax
signal start_HUD3
signal hide_HUD
var cantBalas
var cantAntbody=0
var cantPlus=0
var ScoreInicial

var player = {
"score":0,
"level":0,
"lives":3
}

func _ready():
	Global.set_activo(true)
	$Start.show()
	$TimerStart.start()
	cantBalas=cantBalasMax
	emit_signal("hide_HUD")
	$Nave.change_shot(false)

func _on_TimerStart_timeout():
	$Start.hide()
	emit_signal("start_HUD3")
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	$InicioTimer.start()
	$Nave.show()
	$background.show()
	Global.load_game()
	player=Global.player
	ScoreInicial= player.score
	Global.new_game()
	$HUD_game.actualizarScore(ScoreInicial)
	$HUD_game.actualizarVidas(player.lives)
	$HUD_game.actualizarAnticuerpos(cantAntbody)
	$HUD_game.actualizarEnemigos(0)
	$HUD_game.actualizarBalas(cantBalasMax)
	$sound.play()

func game_over():
	$BacteriaTimer.stop()
	$AntibodyTimer.stop()
	$TimerBalaPlus.stop()
	$ScoreTimer.stop()
	Global.set_activo(false)
	emit_signal("hide_HUD")
	$LevelLoose.visible=true
	$Again.disabled=false
	$Again.visible=true
	if(player.lives<=1):
		get_tree().change_scene("res://Game_over.tscn")
	else:
		Global.save_game(ScoreInicial,player.level,player.lives-1)

func finish():		#Gana el nivel
	Global.set_activo(false)
	$BacteriaTimer.stop()
	$AntibodyTimer.stop()
	$TimerBalaPlus.stop()
	$ScoreTimer.stop()
	emit_signal("hide_HUD")
	$LevelWin.visible=true
	Global.save_game(player.score,player.level+1,player.lives)
	$NextScene.start()
	
func _on_NextScene_timeout():
	get_tree().change_scene("res://body.tscn")

func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()
	$AntibodyTimer.start()
	$TimerBalaPlus.start()
	$Nave.change_shot(true)

func _on_ScoreTimer_timeout():
	player.score += 1
	$HUD_game.actualizarScore(player.score)

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())
	
	var B = Bacteria.instance()
	B.change_bacteria_type(["grande3","chica3"])
	B.select_animation(randi() % B.tipo_bacteria.size())
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.level_call()
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))
	B.change_speed(350,550)

func play_again():
	get_tree().change_scene("res://Level3.tscn")

func _on_AntibodyTimer_timeout():
	var xPos
	var yPos
	var A=Antibody.instance()
	randomize()
	xPos=rand_range(328.479,802.522)
	yPos=rand_range(276.944,1031.992)
	add_child(A)
	#A.play("show_up")
	A.position=Vector2(xPos,yPos)

func _on_Nave_add_kill(x):
	$HUD_game.actualizarEnemigos(x)
	if(cantAntbody>=cantAntbodyMax && x>=cantBactMax):
		finish()

func _on_Nave_catch():
	cantAntbody+=1
	$HUD_game.actualizarAnticuerpos(cantAntbody)
	if(cantAntbody>=cantAntbodyMax && Global.bactKill>=cantBactMax):
		finish()
	else:
		if(cantAntbody>=cantAntbodyMax):
			$AntibodyTimer.stop()
		else:
			$AntibodyTimer.start()

func _on_Nave_shot():
	cantBalas-=1
	$HUD_game.actualizarBalas(cantBalas)
	if(cantBalas<=0):
		$Nave.change_shot(false)

func _on_TimerBalaPlus_timeout():
	var b=Bala_plus.instance()
	#var size=get_viewport().get_visible_rect().size
	randomize()
	var xPos=rand_range(-202.518,258.386)
	var yPos=rand_range(-253.497,461.749)
	#b.global_position=Vector2(xPos,yPos)
	b.position=Vector2(xPos,yPos)
	add_child(b)

func _on_Nave_bala_plus():
	if (cantBalas < cantBalasMax):
		cantBalas+=1
	$HUD_game.actualizarBalas(cantBalas)
	if (cantBalas==1):
		$Nave.change_shot(true)
