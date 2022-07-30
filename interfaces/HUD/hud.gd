extends CanvasLayer


@onready var healthbar := $Control/Info/Rows/Health/HealthBar as TextureProgressBar
@onready var money_label := $Control/Info/Rows/Money/Label as Label


func _process(_delta: float) -> void:
	money_label.text = str(Global.money)


# Needed to set the healthbar's initial values
func _on_tower_initialized(max_health) -> void:
	healthbar.max_value = max_health
	healthbar.value = healthbar.max_value


# Used to update the tower's health
func _on_tower_health_changed(cur_health: int) -> void:
	healthbar.value = cur_health
