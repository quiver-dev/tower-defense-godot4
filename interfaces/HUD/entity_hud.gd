class_name EntityHud
extends Control


const RED := Color("#e86a17")
const YELLOW := Color("#d2b82d")
const GREEN := Color("#88e060")


var tween: Tween

@onready var state_label := $Parameters/StateLabel as Label
@onready var healthbar := $Parameters/Healthbar as TextureProgressBar
@onready var reload_bar := $Parameters/ReloadBar as TextureProgressBar


func _ready() -> void:
	# initialize reload bar
	reload_bar.value = 0


func update_reloadbar(duration: float) -> void:
	tween = get_tree().create_tween()
	tween.tween_callback(reload_bar.show)
	tween.tween_method(_update_bar, reload_bar.value, reload_bar.max_value,
			duration)


func _update_bar(value) -> void:
	reload_bar.value = value
	if value > reload_bar.max_value * 0.0:
		reload_bar.self_modulate = RED
	if value > reload_bar.max_value * 0.33:
		reload_bar.self_modulate = YELLOW # yellow
	if value > reload_bar.max_value * 0.66:
		reload_bar.self_modulate = GREEN # green
	if value == reload_bar.max_value:
		reload_bar.value = reload_bar.min_value


func _on_healthbar_value_changed(value: float) -> void:
	healthbar.self_modulate = RED if value <= healthbar.max_value / 4 else GREEN


# Quoting the documentation, the tree_exiting signal is "emitted when the node
# is still active but about to exit the tree. This is the right place for 
# de-initialization".
func _on_entity_hud_tree_exiting() -> void:
	if tween:
		tween.kill()
