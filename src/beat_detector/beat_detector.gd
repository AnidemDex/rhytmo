extends Node

# Lo que intento hacer es registrar cuando la tecla 
# se presiona y en ese momento revisar el beat
# acorde si se necesita o no presionar en ese momento

signal failed_beat
signal sucessful_beat

var press_needed:bool = false

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("beat_button"):
		check_the_beat()


func check_the_beat():
	if press_needed:
		# Se necesita un beat,
		# checa que tan temprano o tarde se presionó
		pass
	else:
		# No se necesita que el jugador presione
		# el botón todavia
		pass
