extends CanvasLayer


@onready var healthbar := $Info/PanelContainer/Rows/Health/HealthBar as TextureProgressBar
@onready var money_label := $Info/PanelContainer/Rows/Money/Label as Label
@onready var gameover := $UI/GameOver as GameOver


func _process(_delta: float) -> void:
	money_label.text = str(Global.money)


# Needed to set the healthbar's initial values
func _on_tower_initialized(max_health) -> void:
	healthbar.max_value = max_health
	healthbar.value = healthbar.max_value


# Used to update the tower's health
func _on_tower_health_changed(cur_health: int) -> void:
	healthbar.value = cur_health


func _on_tower_destroyed() -> void:
	gameover.appear()