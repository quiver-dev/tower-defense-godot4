extends Area2D


const TURRET_PATH := "res://entities/turrets/"

@onready var turret_popup: CanvasLayer = $TurretPopup


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			turret_popup.show()


func _on_turret_popup_turret_requested(_level: String) -> void:
	# load turret into scene and disable input
	var turret: Turret = load(TURRET_PATH.plus_file("turret.tscn")).instantiate()
	turret.position = Vector2.ZERO
	input_pickable = false
	add_child(turret, true)
	# connect turret signal to restore input detection on turret disabled
	turret.turret_disabled.connect(_on_turret_disabled)


func _on_turret_disabled() -> void:
	input_pickable = true
