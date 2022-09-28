class_name GameOver
extends PanelContainer


@onready var anim_player := $AnimationPlayer as AnimationPlayer


# Note that the parent node MUST have its process mode set to "Always"
# in order for this node to keep processing after we pause the tree
func enable(value: bool) -> void:
	Global.is_gameover = value
	get_tree().paused = value
	visible = value
	anim_player.play("show" if value else "RESET")


func _on_retry_pressed() -> void:
	enable(false)
	Scenes.change_scene(Scenes.MAP_TEMPLATE)


func _on_exit_pressed() -> void:
	enable(false)
	Scenes.change_scene(Scenes.MAIN_MENU)
