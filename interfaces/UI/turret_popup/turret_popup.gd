extends CanvasLayer
# TODO: try using the new Popup class when they stabilize it. At the
# moment it seems broken, or at least there's no documentation to
# understand how to use it.


func _on_close_pressed() -> void:
	hide()


func _on_turret_popup_visibility_changed() -> void:
	Global.is_popup_displaying = visible
