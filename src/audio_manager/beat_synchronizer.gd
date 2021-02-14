extends AudioStreamPlayer

signal beat(data)
signal bar(data)

# Figuras musicales basadas en negras
const T_REDONDA = 4.0
const T_BLANCA = 2.0
const T_NEGRA = 1.0
const T_CORCHEA = 1.0/2.0
const T_SEMICORCHEA = 1.0/4.0
const T_FUSA = 1.0/8.0
const T_SEMIFUSA = 1.0/16.0

const SELECTED_TIME = T_SEMIFUSA

var bpm : int = 100

# TimePerBeat: Cada cuanto se produce una negra
# considerando un beat como una negra
var tpb: float = 60.0/bpm
# Cada cuanto se produce un beat (cambia la constante para
# una medida diferente)
var beat_time: float = tpb * SELECTED_TIME
var beats_per_bar: int = 8
# Cuando se producirá otro beat
var next_beat_time: float = 0.0
# Cuando se producirá otro compás (los compas se componen de beats)
var next_bar_time: float = 0.0
var song_position: float = 0.0

var beat_number: int = 0
var bar_number: int = 0

func _physics_process(_delta: float) -> void:
	if playing:
		song_position = (
			get_playback_position()
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
			)


func _report_beat() -> void:
	if song_position > next_bar_time:
		next_bar_time += tpb*beats_per_bar
		bar_number += 1
		beat_number = 0
		
		var data: Dictionary = {
			"beat": beat_number/SELECTED_TIME,
			"beat_number": beat_number,
			"bar": bar_number
		}
		
		emit_signal("bar", data)

	
	if song_position > next_beat_time:
		next_beat_time += beat_time
		beat_number += 1
		
		var data: Dictionary = {
			"beat": beat_number/SELECTED_TIME,
			"beat_number": beat_number,
			"bar": bar_number
		}
		
		emit_signal("beat", data)
