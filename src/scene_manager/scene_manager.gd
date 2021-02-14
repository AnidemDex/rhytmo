extends CanvasLayer


onready var transitions:AnimationPlayer = $AnimationPlayer

func change_scene(scene_path:String, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	$Control.visible = true
	transitions.play("fade")
	yield(transitions, "animation_finished")
	assert(get_tree().change_scene(scene_path) == OK)
	transitions.play_backwards("fade")
	yield(transitions, "animation_finished")
	$Control.visible = false
