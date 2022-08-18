extends Area2D


var turret: Turret  # turret assigned to this slot

@onready var turret_popup := $TurretPopup as CanvasLayer
@onready var turret_actions := $TurretActions as VBoxContainer


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and \
			event.button_index == MOUSE_BUTTON_LEFT:
		if turret:
			turret_actions.visible = not turret_actions.visible
		else:
			turret_popup.show()


func _on_turret_replace_requested() -> void:
	# get current turret's value, give back half money
	# show turret popup menu
	pass


func _on_turret_repair_requested() -> void:
	# pay money and fix turret
	pass


func _on_turret_remove_requested() -> void:
	# remove the turret
	# give back half money
	pass


func _on_turret_popup_turret_requested(type: String) -> void:
	# load turret into scene and disable input
	turret = load(Scenes.get_turret_path(type)).instantiate()
	turret.position = Vector2.ZERO
	add_child(turret, true)
	turret.health = 1  # TEST: remove this
	# connect turret signal to restore input detection on turret disabled
	turret.turret_disabled.connect(_on_turret_disabled)


func _on_turret_disabled() -> void:
	turret = null
