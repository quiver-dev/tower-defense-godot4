class_name GameOver
extends PanelContainer


@onready var anim_player := $AnimationPlayer as AnimationPlayer


# Note that the parent node MUST have its process mode set to "Always"
# in order for this to work
func appear() -> void:
	get_tree().paused = true
	visible = true
	anim_player.play("show")


func disappear() -> void:
	get_tree().paused = false
	visible = false
	anim_player.play("RESET")


func _on_retry_pressed() -> void:
	disappear()
	Scenes.change_scene(Scenes.MAP)


func _on_exit_pressed() -> void:
	disappear()
	Scenes.change_scene(Scenes.MAIN_MENU)
