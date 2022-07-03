extends Projectile


func _on_projectile_area_entered(area: Area2D) -> void:
	if area is Objective:
		(area as Objective).take_damage(damage)
		queue_free()


func _on_projectile_body_entered(body: Node2D) -> void:
	if body is Turret:
		(body as Turret).take_damage(damage)
		queue_free()
