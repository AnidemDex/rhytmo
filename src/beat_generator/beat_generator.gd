extends Node

signal generate

func _ready() -> void:
	AudioManager.connect("beat", self, "_on_beat")

func _on_beat(data):
	pass
