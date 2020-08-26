extends Area2D

signal iniciar_juego_zona0
signal iniciar_juego_zona1
signal iniciar_juego_zona2
signal iniciar_juego_zona3
signal start_HUD0
signal hide_HUD

export (PackedScene) var Scene1
export (PackedScene) var Scene2
export (PackedScene) var Scene3
export (PackedScene) var Scene4


var player = {
"score":0,
"level":0,
"lives":3,
"record":0
}

var zone
var pos={
	P0=[-21,-259],
	P1=[-7,-231],
	P2=[-12,-303],
	P3=[11,-147],
}
var body_type_used ={}
#var body_type=["skin","tooth","eyes","thyroid","diaphragm","intestine","heart","head"]
var body_type=["eyes","tooth","head","heart"]


func _ready():
	Global.load_game()
	player=Global.player
	$HUD_game.actualizarRecord(player.record)
	$HUD_game.actualizarVidas(player.lives)
	emit_signal("start_HUD0")
	initialize()
	zone=selectZone()
	configure_zone()
	$button_zone.show()
	yield($Timer, "timeout")
	$alarm.play()

func inicio():
	pass

func inicio_level():
	hide_lights()
	zone=selectZone()
	configure_zone()
	$button_zone.show()
	$body.show()
	yield($Timer, "timeout")
	#$alarm.play()

func selectZone():
	var i=0
	#zone=int(rand_range(0,6))
	
	#if(body_type_used[zone]==1):
	#	i=0
	while(body_type_used[i]==1):
		i=i+1
	zone=i
	return zone

func initialize():
	var i=0
	while(i<=player.level):
		body_type_used[i]=1  #[1,_,_,_]
		i+=1
	while(i<=(body_type.size()-1)):
		body_type_used[i]=0    #[1,0,0,0]
		i+=1

func get_pos():
	return pos["P"+str(zone)]

func configure_zone():
	var expos=get_pos() #Busca posicion de la luz
	#$button_zone.text=str(zone)
	$button_zone.text=''
	#var exbody_type=get_object()
	$button_zone.set_position(Vector2(expos[0],expos[1]))
	$button_zone.set_size(Vector2(41,39))
	if(zone==0):
		$button_zone.set_size(Vector2(83,29))
		$body/eyes.enabled=true
		$body/eyes.show()
	else:
		if(zone==1):
			$body/tooth.enabled=true
			$button_zone.set_size(Vector2(55,29))
			$body/tooth.show()
		else:
			if(zone==2):
				$body/head.enabled=true
				$button_zone.set_size(Vector2(68,46))
				$body/head.show()
			else:
				if(zone==3):
					$body/heart.enabled=true
					$button_zone.set_size(Vector2(55,52))
					$body/heart.show()
				else:
					if(zone==5):
						$body/intestine.enabled=true
						$button_zone.set_size(Vector2(97,75))
						$body/intestine.show()
					else:
						if(zone==4):
							$body/thyroid.enabled=true
							$button_zone.set_size(Vector2(46,24))
							$body/thyroid.show()
						else:
							$body/skin.enabled=true
							$button_zone.set_size(Vector2(35,76))
							$body/skin.show()
	#$body.animation="body_"+body_type[zone]
	$body/light_animation.play(body_type[zone])

func _process(_delta):
	pass

func _on_Button_pressed():
	$body.hide()
	$button_zone.hide()
	#$alarm.playing=false
	$body/light_animation.stop(false)
	#emit_signal("iniciar_juego_zona"+str(zone))
	emit_signal("iniciar_juego_zona"+str(zone))
	emit_signal("hide_HUD")

func hide_lights():
	$body/eyes.hide()
	$body/head.hide()
	$body/heart.hide()
	$body/intestine.hide()
	$body/skin.hide()
	$body/thyroid.hide()
	$body/tooth.hide()

func juego_zona0():
	get_tree().change_scene_to(Scene1)
	
func juego_zona1():
	get_tree().change_scene_to(Scene2)
	
func juego_zona2():
	get_tree().change_scene_to(Scene3)
	
func juego_zona3():
	get_tree().change_scene_to(Scene4)
