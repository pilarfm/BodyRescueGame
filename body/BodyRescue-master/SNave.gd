extends "res://Nave.gd"

var can_shot=true
signal killed
signal shot
signal bala_plus
var cantBact
var mousePosition
const BALA = preload("res://Bala.tscn")

func _ready():
	limite = get_viewport_rect().size

func _process(delta):
	cantBact=Global.bactKill
	if (Global.activo):
		emit_signal("killed",cantBact)
	Global.setNave(self)

func _input(event):
	var istouch = event is InputEventScreenTouch
	var ismouse= event is InputEventMouseButton
	if(Global.activo && can_shot && (istouch or ismouse)):
		$mira.look_at(event.position)
		if ((event.button_index == BUTTON_LEFT or istouch) and event.pressed):
			if(event.position != position):
				var direction = (event.global_position - global_position).normalized()
				var bala = BALA.instance()
				bala.global_position = global_position + direction
				#bala.set_bala_direction(direction)
				bala.rotation=rotation+$mira.get_rotation()
				bala._ready()
				get_parent().add_child(bala)
				emit_signal("shot")


func _on_Nave_area_entered(area):
	if ("Ataque" in area.name):		#Ataque del boss
		alive=false
		$explode.play()
		emit_signal("golpe")
	else:
		if ("Bala_plus" in area.name):
			emit_signal("bala_plus")
		else:
			emit_signal("catch")

func change_shot(cond):
	can_shot=cond
	
func set_alive(cond):
	alive=cond
