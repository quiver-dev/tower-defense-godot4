@tool  # WARN: this appears to be necessary. Investigate further.
extends Shooter


func _ready() -> void:
	super()
	# spawn the wanted bullets
	_spawn_missiles()


func shoot() -> void:
	can_shoot = false
	# move children to the bullet container to prevent the gun's rotation
	# from influencing the missiles' rotation
	for muzzle in gun.get_children():
		var bullet: Bullet = muzzle.get_child(0)
		muzzle.remove_child(bullet)
		bullet_container.add_child(bullet, true)
		bullet.start(muzzle.global_position,
				gun.rotation + randf_range(-bullet_spread, bullet_spread),
				targets.front())
	firerate_timer.start(fire_rate)
	# show reload time on HUD
	emit_signal("has_shot", firerate_timer.wait_time)


func _spawn_missiles() -> void:
	for i in gun.get_child_count():
		if bullet_type:
			var muzzle := gun.get_child(i)
			var bullet: Bullet = bullet_type.instantiate()
			bullet.name = "Missile%d" % (i + 1)
			bullet.rotation = -PI / 2
			muzzle.add_child(bullet, true)


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
	_spawn_missiles()
