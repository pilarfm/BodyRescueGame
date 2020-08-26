extends Area2D 

var speed=300
var steer_force=100
var velocity = Vector2()
var acceleration = Vector2()
var target = null

func start(_position, _direction, _target=null):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * speed
	target = _target

func seek():
	var desired = (target.position - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func _process(delta):
	if (Global.activo==false):
		queue_free()
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
	position += velocity * delta

func _on_Ataque_area_entered(area):
	if("Bala" in area.name):
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
