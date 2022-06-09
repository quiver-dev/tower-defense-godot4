extends Bullet


@export var steer_force: int = 40

var acceleration: Vector2


func _physics_process(delta: float) -> void:
	if target:
		acceleration += _steer()
		velocity += acceleration * delta
#		velocity = velocity.clamp(-speed, speed)
		rotation = velocity.angle()
	global_position += velocity * delta


func _steer() -> Vector2:
	# calculate the desired direction vector at maximum speed
	var desired := global_position.direction_to(target.global_position) * speed
	# return the amount we can turn towards the desired direction
	return velocity.direction_to(desired) * steer_force


func _on_bullet_body_entered(body: Node2D) -> void:
	if body is Enemy:
		(body.get_fsm() as EnemyFSM).is_hit(damage)
		queue_free()
