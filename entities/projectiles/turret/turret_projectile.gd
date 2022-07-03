extends Projectile


func _on_projectile_body_entered(body: Node2D) -> void:
	if body is Enemy:
		(body.get_fsm() as EnemyFSM).is_hit(damage)
		queue_free()
