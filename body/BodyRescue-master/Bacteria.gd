extends RigidBody2D

export (int) var velocidad_min
export (int) var velocidad_max
var tipo_bacteria = ["grande1","chica1"]

func _ready():
	$CollisionShape3down.disabled=true
	$CollisionShape3up.disabled=true
	$CollisionShape2.disabled=true
	$CollisionShape4.disabled=true
	
func _process(delta):
	if (Global.activo==false):
		queue_free()

func _on_Visibilidad_screen_exited():
	queue_free()  #elimina la bacteria si se sale de la pantalla

func change_bacteria_type(type):
	tipo_bacteria=type

func select_animation(x):
	$AnimatedSprite.animation=tipo_bacteria[x]

func _on_Level1_hide_bacteria():
	visible=false

func elim():
	$AnimatedSprite.visible=false
	$punch.play()
	set_collision_mask_bit(19,true)
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(1,false)

func level_call():
	var aux=$AnimatedSprite.animation
	$CollisionShape2D.disabled=true
	if("2" in $AnimatedSprite.animation):
			$CollisionShape2.disabled=false
			if("grande" in $AnimatedSprite.animation):
				$CollisionShape2.rotation=70
	else:
		if("3" in $AnimatedSprite.animation):
			$CollisionShape3down.disabled=false
			$CollisionShape3up.disabled=false
			if("grande" in $AnimatedSprite.animation):
				$CollisionShape3down.rotation=90
				$CollisionShape3down.position=Vector2(13.218,-16.249)
				$CollisionShape3up.rotation=155
				$CollisionShape3up.position=Vector2(-22.537,-37.776)
		else:
			if("4" in $AnimatedSprite.animation):
				$CollisionShape4.disabled=false
			if("grande" in $AnimatedSprite.animation):
				$CollisionShape4.rotation=150
				$CollisionShape4.position=Vector2(-4.078,-31.606)

func change_speed(minV,maxV):
	velocidad_min=minV
	velocidad_max=maxV

func _on_punch_finished():
	queue_free()
