extends Area2D


var turret: Turret  # turret assigned to this slot

@onready var turret_popup := $TurretPopup as CanvasLayer
@onready var turret_actions := $TurretActions as VBoxContainer


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and \
			event.button_index == MOUSE_BUTTON_LEFT:
		if is_instance_valid(turret):
			turret_actions.visible = not turret_actions.visible
		else:
			turret_popup.show()


func _on_turret_replace_requested() -> void:
	turret_actions.hide()
	turret.remove()
	turret_popup.show()


func _on_turret_repair_requested() -> void:
	if turret.repair():
		turret_actions.hide()
	else:
		var tween := create_tween().set_trans(Tween.TRANS_BACK).\
				set_ease(Tween.EASE_IN_OUT)
		var repair_btn := get_node("TurretActions/Repair") as Button
		repair_btn.modulate = Color("ff383f")
		tween.tween_property(repair_btn, "modulate", Color("fff"), 0.25)


func _on_turret_remove_requested() -> void:
	turret_actions.hide()
	turret.remove()


func _on_turret_popup_turret_requested(type: String) -> void:
	# load turret into scene and disable input
	turret = load(Scenes.get_turret_path(type)).instantiate()
	turret.position = Vector2.ZERO
	add_child(turret, true)
#	turret.health = 10  # WARN: remove this
	# connect turret signal to restore input detection on turret disabled
	turret.turret_disabled.connect(_on_turret_disabled)


func _on_turret_disabled() -> void:
	turret_actions.hide()
	turret = null  # necessary because turret is still on exploding animation


func _on_turret_popup_visibility_changed() -> void:
	if turret_popup.visible:
		turret_actions.hide()


func _on_turret_actions_visibility_changed() -> void:
	if turret_actions.visible:
		turret_popup.hide()
