extends KinematicBody2D

const cima = Vector2(0, -1)
const gravidade = 10
const Aceleracao = 50
const pulo = -400
const Velocidade_Max = 200
var movimento = Vector2()
func _physics_process(delta):
	
	#=-=-=Código Gravidade=-=-=
	movimento.y += gravidade
	#=-=-=Código Gravidade=-=-=
	
	#=-=-=Codigo Mov.Direita=-=--=
	if Input.is_action_pressed("ui_right"):
		movimento.x = min(movimento.x + Aceleracao , Velocidade_Max)
		$Sprite.flip_h = false
		if  is_on_floor() == true:
			$Sprite.play("Correndo")
	#=-=-=Codigo Mov.Direita=-=--=
	
	#=-=-=Codigo Mov.Esquerda=-=-=
	elif Input.is_action_pressed("ui_left"):
		movimento.x = max(movimento.x - Aceleracao , -Velocidade_Max)
		$Sprite.flip_h = true
		if  is_on_floor() == true:
			$Sprite.play("Correndo")
	#=-=-=Codigo Mov.Esquerda=-=-=
	
	#=-=-=Codigo Parado=-=-=
	else:
		$Sprite.play("Parado")
	#=-=-=Codigo Parado=-=-=
	
	#=-=-=Código Atrito=-=-=
	if is_on_floor():
		movimento.x = lerp(movimento.x, 0, 0.2)
	else:
		movimento.x = lerp(movimento.x, 0, 0.005)
	#=-=-=Código Atrito=-=-=
	
	#=-=-=Código de Pulo=-=-=
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		movimento.y = pulo
		get_node("Sprite").play("Pulando")
	if is_on_floor() == false and movimento.y > 0:
		get_node("Sprite").play("Caindo")
	elif is_on_floor() == false and movimento.y < 0:
		get_node("Sprite").play("Pulando")
	#=-=-=Código de Pulo=-=-=
	
	
	
	movimento = move_and_slide(movimento, cima)
	pass
