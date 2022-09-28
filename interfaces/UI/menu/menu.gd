extends Control


@onready var menu_panel := $PanelContainer as PanelContainer
@onready var how_to_play := $HowToPlay as Panel


func _on_start_pressed() -> void:
	Scenes.change_scene(Scenes.MAP_TEMPLATE)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_how_to_play_pressed() -> void:
	how_to_play.show()
	menu_panel.hide()


func _on_back_pressed() -> void:
	how_to_play.hide()
	menu_panel.show()
