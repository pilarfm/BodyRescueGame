extends CanvasLayer

signal iniciar_juego

func update_score(Puntos):
	$ScoreLabel.text = str(Puntos)

func _on_BotonPlay_pressed():
	$BotonPlay.hide()
	$Fondo.hide()
	emit_signal("iniciar_juego")
