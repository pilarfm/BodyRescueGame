extends KinematicBody2D

signal life_modify
signal Attack

export (PackedScene) var Attack_thing
export (int) var life
onready var parent=get_parent()
var speed=400
var alive=false
var velocity=Vector2(1000,0)
var attack=false
var target
var target_dir
var current_dir

func _ready():
	$AnimatedSprite.animation= "normal"
	$Area2D/CollisionShapeBoos.disabled=false
	$TimerAttack.start()

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)


func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position=Vector2()

func set_alive(a):
	alive=a


func _on_Area2D_area_entered(area):
	if ("Bala" in area.name):
		if (life>=10):
			life-=10
		$AnimationPlayer.play("damage")
		$punch.play()
		if(life<=0):
			print(rotation_degrees)
			print(rotation)
			$AnimatedSprite.animation="dead"
			$TimerAttack.stop()
			alive=false
			velocity=0
			$Area2D/CollisionShapeBoos.set_deferred('disabled',true);
			rotation=0
			rotation_degrees=0
		emit_signal("life_modify",life)
	
func shoot():
	var dir=Vector2(1,0).rotated(self.global_rotation)
	var aux=Global.getNave()
	emit_signal("Attack",Attack_thing,self.global_position,dir,aux)
	

func _on_TimerAttack_timeout():
	shoot()
	$AnimatedSprite.animation="angry"
	$TimerAnimation.start()



func _on_TimerAnimation_timeout():
	$AnimatedSprite.animation="normal"

func detener():
	$TimerAttack.stop()
