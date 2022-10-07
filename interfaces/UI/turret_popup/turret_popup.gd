extends CanvasLayer


signal turret_requested(type: String)

const PRICE_LABEL_PATH := "Background/Panel/Turrets/%s/Label"


func _ready() -> void:
	# initialize turret prices
	for turret in $Background/Panel/Turrets.get_children():
		var price_label := turret.get_node("Label") as Label
		price_label.text = str(Global.turret_prices[String(turret.name).to_lower()])


func _on_close_pressed() -> void:
	hide()


# The Background node mimics the old "exclusive" Popup functionality:
# when clicking outside the popup panel, the popup closes.
func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			hide()


# Note that you can pass custom arguments to a signal by enabling advanced 
# settings  when connecting a signal to a method using the editor.
# In this case we are passing the turret type based on which button is pressed.
func _on_button_pressed(type: String) -> void:
	if Global.money >= Global.turret_prices[type]:
		Global.money -= Global.turret_prices[type]
		turret_requested.emit(type)
		hide()
	else:
		var tween := create_tween().set_trans(Tween.TRANS_BACK).\
				set_ease(Tween.EASE_IN_OUT)
		var price_label := get_node(PRICE_LABEL_PATH % [type.capitalize()]) as Label
		price_label.modulate = Color("ff383f")
		tween.tween_property(price_label, "modulate", Color("fff"), 0.25)
