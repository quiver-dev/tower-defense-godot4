extends PanelContainer


@onready var anim_player := $AnimationPlayer as AnimationPlayer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and not Global.is_gameover:
		# toggle pause menu based on whether the game is paused or not
		_enable(not get_tree().paused)


func _enable(value: bool) -> void:
	get_tree().paused = value
	visible = value
	anim_player.play("show" if value else "hide")


func _on_resume_pressed() -> void:
	_enable(false)


func _on_restart_pressed() -> void:
	_enable(false)
	Scenes.change_scene(Scenes.MAP_TEMPLATE)


func _on_exit_pressed() -> void:
	_enable(false)
	Scenes.change_scene(Scenes.MAIN_MENU)
