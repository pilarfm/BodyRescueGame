extends Area2D

const SPEED = 600
var velocity = Vector2()
var angulo
var destroyed = false

func _ready():
	angulo = Vector2( cos(rotation), sin(rotation) )

func _physics_process(delta):

	position+= (angulo * SPEED) * delta


func _on_Bala_body_entered(body):
	if body != self:
		if("Bacteria" in body.name):
			body.elim()
			Global.new_bacteria_kill()
		else:
			if("Bala" in body.name):
				body.queue_free()
		queue_free()

		
func _on_Bala_area_entered(area):
	if ("Ataque" in area.name):
		queue_free()

func _on_Visibilidad_screen_exited():
	queue_free() 
