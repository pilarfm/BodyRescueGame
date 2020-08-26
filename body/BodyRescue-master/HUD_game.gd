extends CanvasLayer

func _ready():
	pass 

func actualizarScore(score):
	$Score.text = str(score)

func actualizarVidas(vidas):
	$Vidas.text = str(vidas)

func actualizarAnticuerpos(a):
	$Anticuerpos.text = str(a)
	
func actualizarEnemigos(e):
	$Enemigos.text = str(e)

func actualizarVidaBoss(vida):
	$VidaBoss.text=str(vida)
	
func actualizarRecord(r):
	$Record/Valor.text=str(r)

func actualizarBalas(b):
	$Balascant.text=str(b)

func _on_Area2D_start_HUD0():
	$Record.visible=true
	$Record/Valor.visible=true
	$RecordPic.visible=true
	$Vidas.visible=true
	$Vitamina.visible=true

func _on_Level1_start_HUD1():
	$Analog.visible=true
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=false
	$Anticuerpos.visible=false
	$Enemigos.visible=false
	$EnemigosPic.visible=false
	$VidaBoss.visible=false
	$BossPic.visible=false

func _on_Level2_start_HUD2():
	$Analog.visible=true
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=true
	$Anticuerpos.visible=true
	$Enemigos.visible=false
	$EnemigosPic.visible=false
	$VidaBoss.visible=false
	$BossPic.visible=false

func _on_Level3_start_HUD3():
	$Analog.visible=true
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=true
	$Anticuerpos.visible=true
	$Enemigos.visible=true
	$EnemigosPic.visible=true
	$VidaBoss.visible=false
	$BossPic.visible=false
	$BalasPic.visible=true
	$Balascant.visible=true
	
func _on_Level4_start_HUD4():
	$Analog.visible=true
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$VidaBoss.visible=true
	$BossPic.visible=true
	$AnticuerposPic.visible=false
	$Anticuerpos.visible=false
	$Enemigos.visible=false
	$EnemigosPic.visible=false
	$BalasPic.visible=true
	$Balascant.visible=true
  
func hide_HUD():
	$Analog.visible=false
	$Vidas.visible=false
	$Vitamina.visible=false
	$Reloj.visible=false
	$Score.visible=false
	$AnticuerposPic.visible=false
	$Anticuerpos.visible=false
	$Enemigos.visible=false
	$EnemigosPic.visible=false
	$VidaBoss.visible=false
	$BossPic.visible=false
	$BalasPic.visible=false
	$Balascant.visible=false
	$Record.visible=false
	$Record/Valor.visible=false
	$RecordPic.visible=false




