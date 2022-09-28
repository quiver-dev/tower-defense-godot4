class_name Hud
extends CanvasLayer


@onready var healthbar := $Info/PanelContainer/Rows/Health/HealthBar as TextureProgressBar
@onready var money_label := $Info/PanelContainer/Rows/Money/Label as Label
@onready var gameover := $UI/GameOver as GameOver
@onready var wave_label := $Info/WaveLabel as Label


func _process(_delta: float) -> void:
	money_label.text = str(Global.money)


# Needed to set the healthbar's initial values
func initialize(max_health) -> void:
	healthbar.max_value = max_health
	healthbar.value = healthbar.max_value


# Used to update the tower's health
func _on_tower_health_changed(cur_health: int) -> void:
	healthbar.value = cur_health


func _on_tower_destroyed() -> void:
	gameover.enable(true)


# Here just in case a different gameover screen will be used in case of victory
func _on_spawner_waves_finished() -> void:
	gameover.enable(true)


func _on_spawner_wave_started(current_wave: int) -> void:
	wave_label.text = "Wave: %d" % current_wave
