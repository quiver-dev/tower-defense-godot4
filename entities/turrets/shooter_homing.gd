@tool  # WARN: this appears to be necessary. Investigate further.
extends Shooter


var muzzle_idx := 0  # used to determine which missile to fire


func _ready() -> void:
	super()
	# spawn the wanted bullets
	_spawn_missiles()


func shoot() -> void:
	can_shoot = false
	# move children to the bullet container to prevent the gun's 
	# rotation from influencing the missiles' rotation
	var muzzle = gun.get_child(muzzle_idx)
	var bullet: Bullet = muzzle.get_child(0)
	muzzle.remove_child(bullet)
	bullet_container.add_child(bullet, true)
	bullet.start(muzzle.global_position,
			rotation + randf_range(-bullet_spread, bullet_spread),
			targets.front())
	firerate_timer.start(fire_rate)
	muzzle_idx = _wrap_index(muzzle_idx + 1, bullet_count)
	# show reload time on HUD
	emit_signal("has_shot", firerate_timer.wait_time)


# Function to wrap an index around an array (circular array)
func _wrap_index(index: int, size: int) -> int:
	return ((index % size) + size) % size


func _spawn_missiles() -> void:
	for i in gun.get_child_count():
		var muzzle := gun.get_child(i)
		if bullet_type and muzzle.get_child_count() == 0:
			var bullet: Bullet = bullet_type.instantiate()
			bullet.name = "Missile%d" % (i + 1)
			bullet.rotation = -PI / 2
			muzzle.add_child(bullet, true)


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
	_spawn_missiles()
