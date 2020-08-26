extends Area2D

export (int) var Velocidad
var Movimiento = Vector2()
var posAnt=Vector2()
var limite
var alive=true
var aux
var auxx
var auxy
signal golpe
signal catch

func _ready():
	$ImpulseArriba.emitting=true
	$ImpulseArriba.visible=true
	$CollisionShapefrente.disabled=false
	limite = get_viewport_rect().size

func _process(delta):
	#print(position)
	Movimiento = Vector2()  #reinciar el valor
	posAnt=position
	
	#Para mover la nave con BOTONES ##################################
	if Input.is_action_pressed("ui_right"):
		Movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		Movimiento.x -= 1
	if Input.is_action_pressed("ui_down"):
		Movimiento.y += 1
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -= 1

	if Movimiento.length() > 0:   #Verificar si se esta moviendo
		Movimiento = Movimiento.normalized() * Velocidad  #NOrmalizar la velocidad
		position += Movimiento * delta	#actualizar los movimientos

	if(Movimiento.x!=0&&Movimiento.y!=0):
		$CollisionShapefrente.disabled =true
		$CollisionShapelado.disabled=true
		$AnimatedSprite.animation="diag"
		auxx=Movimiento.x < 0
		auxy=Movimiento.y > 0
		$AnimatedSprite.flip_h = auxx
		$AnimatedSprite.flip_v = auxy
		enable_dig_collisionShapes(auxx,auxy)
		stop_emitions()
	elif (Movimiento.x != 0):   #posicionar al sprite depende de los movimientos
		#$AnimatedSprite.rotation=0
		$ImpulseAbajo.emitting=false
		$ImpulseArriba.emitting=false
		$AnimatedSprite.animation = "lado"
		aux=Movimiento.x < 0
		$AnimatedSprite.flip_h = aux
		if(aux):
			$ImpulseLadoDer.emitting=false
			$ImpulseLadoIzq.emitting=true
		else:
			$ImpulseLadoDer.emitting=true
			$ImpulseLadoIzq.emitting=false
		$CollisionShapediagder.disabled=true
		$CollisionShapediagizq.disabled=true
		$CollisionShapefrente.disabled = true
		$CollisionShapelado.disabled=false
	elif Movimiento.y != 0:
		#$AnimatedSprite.rotation=0
		$ImpulseLadoDer.emitting=false
		$ImpulseLadoIzq.emitting=false
		$AnimatedSprite.animation = "frente"
		aux=Movimiento.y > 0
		$AnimatedSprite.flip_v = aux
		if(aux):
			$ImpulseAbajo.emitting=true
			$ImpulseArriba.emitting=false
		else:
			$ImpulseAbajo.emitting=false
			$ImpulseArriba.emitting=true
		$CollisionShapediagder.disabled=true
		$CollisionShapediagizq.disabled=true
		$CollisionShapefrente.disabled =false
		$CollisionShapelado.disabled=true
	
	#Para mover la nave con el ANALOGICO #####################
	position.x+=Global.analogico.x *Velocidad*delta
	position.y-=Global.analogico.y *Velocidad*delta
	
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)
	
	var dir=Vector2(Global.analogico.y,Global.analogico.x)
	
	look_at(get_transform().origin+dir)
	
	

func stop_emitions():
	$ImpulseAbajo.emitting=false
	$ImpulseArriba.emitting=false
	$ImpulseLadoDer.emitting=false
	$ImpulseLadoIzq.emitting=false

func enable_dig_collisionShapes(auxx,auxy):
	if(!auxx&&!auxy):
		$CollisionShapediagder.disabled=false
		$CollisionShapediagizq.disabled=true
	elif(auxx&&!auxy):
		$CollisionShapediagder.disabled=true
		$CollisionShapediagizq.disabled=false
	elif(auxx&&auxy):
		$CollisionShapediagder.disabled=false
		$CollisionShapediagizq.disabled=true
	else:
		$CollisionShapediagder.disabled=true
		$CollisionShapediagizq.disabled=false

func _on_Nave_body_entered(_body):  #cuando hay una colision con un cuerpo
	$CollisionShapefrente.set_deferred('disabled',true);
	$CollisionShapelado.set_deferred('disabled',true);
	$CollisionShapediagder.set_deferred('disabled',true);
	$CollisionShapediagizq.set_deferred('disabled',true);
	if (alive):
		hide()   #se oculta cuando recibe un golpe
		alive=false
		$explode.play()
		emit_signal("golpe")
	
func inicio(pos):
	alive=true
	position = pos   #mostrar el personaje
	show()

func _on_Nave_area_entered(_area):
	emit_signal("catch")
