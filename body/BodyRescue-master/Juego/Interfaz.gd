extends CanvasLayer

signal iniciar_juego	


func _on_BotonPlay_pressed():
	$BotonPlay.hide()
	emit_signal("iniciar_juego")
	
