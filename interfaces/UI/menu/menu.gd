extends Control


func _on_start_pressed() -> void:
	Scenes.change_scene(Scenes.MAP)


func _on_quit_pressed() -> void:
	get_tree().quit()
