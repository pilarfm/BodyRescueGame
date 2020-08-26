extends Area2D

func _ready():
	$antibody.playing=true
	antibody_show()
	$antibodyCollision.disabled=false
	
func _process(delta):
	if (Global.activo==false):
		queue_free()

func antibody_show():
	$antibodyAnimation.play("rotate")

func area_entered(area):
	hide()
	queue_free()
