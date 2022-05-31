extends Bullet


func _on_bullet_body_entered(body: Node2D) -> void:
	if body is Enemy:
		(body.get_fsm() as EnemyFSM).is_hit(damage)
		queue_free()
