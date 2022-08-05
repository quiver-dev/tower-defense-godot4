extends PanelContainer


@onready var anim_player := $AnimationPlayer as AnimationPlayer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and not Global.is_gameover:
		# toggle pause menu based on whether the game is paused or not
		enable(not get_tree().paused)


func enable(value: bool) -> void:
	get_tree().paused = value
	visible = value
	anim_player.play("show" if value else "hide")
