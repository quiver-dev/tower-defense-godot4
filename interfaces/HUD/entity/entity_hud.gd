class_name EntityHud
extends Control


const RED := Color("#e86a17")
const YELLOW := Color("#d2b82d")
const GREEN := Color("#88e060")

@onready var state_label := $Parameters/StateLabel as Label
@onready var healthbar := $Parameters/Healthbar as TextureProgressBar
@onready var reload_bar := $Parameters/ReloadBar as TextureProgressBar


func _ready() -> void:
	# initialize reload bar
	reload_bar.value = 0


# We use a tween to animate the reloadbar. Note that we use Object.create_tween()
# instead of SceneTree.create_tween() to bind it to this object. This means
# that "the tween will halt the animation when the object is not inside tree 
# and the Tween will be automatically killed when the bound object is freed"
func update_reloadbar(duration: float) -> void:
	var tween := create_tween()
	tween.tween_callback(reload_bar.show)
	tween.tween_method(_update_bar, reload_bar.value, reload_bar.max_value,
			duration)


func _update_bar(value) -> void:
	reload_bar.value = value
	if value > reload_bar.max_value * 0.0:
		reload_bar.self_modulate = RED
	if value > reload_bar.max_value * 0.33:
		reload_bar.self_modulate = YELLOW
	if value > reload_bar.max_value * 0.66:
		reload_bar.self_modulate = GREEN
	if value == reload_bar.max_value:
		reload_bar.value = reload_bar.min_value


func _on_healthbar_value_changed(value: float) -> void:
	healthbar.self_modulate = RED if value <= healthbar.max_value / 4 else GREEN
