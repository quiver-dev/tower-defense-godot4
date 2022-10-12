extends Node2D


func _ready() -> void:
	Global.money = 5000
	for enemy in $Enemies.get_children():
		(enemy as Enemy).move_to($Objective.global_position)
		if enemy is ShootingEnemy:
			(enemy as ShootingEnemy).shooter.projectile_instanced.connect(
					_on_enemy_projectile_instanced)

func _on_enemy_projectile_instanced(projectile: Projectile) -> void:
	add_child(projectile, true)
