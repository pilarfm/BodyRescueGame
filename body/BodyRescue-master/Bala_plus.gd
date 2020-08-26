extends Area2D


func _ready():
	$TimerVida.start()

func _process(delta):
	if (Global.activo==false):
		queue_free()

func _on_Bala_plus_area_entered(area):
	queue_free()


func _on_TimerVida_timeout():
	queue_free()
