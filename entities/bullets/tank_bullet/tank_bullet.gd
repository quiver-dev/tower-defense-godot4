extends Bullet


func _on_bullet_body_entered(body: Node2D) -> void:
	if body is Turret:
		(body as Turret).take_damage(damage)
