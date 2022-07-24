@tool  # WARN: this appears to be necessary. Investigate further.
extends Shooter
# TODO: try reducing code duplication in shoot function.
# Also find a way to improve the muzzle flash animation.


var muzzle_idx := 0  # used to determine which missile to fire


func shoot() -> void:
	can_shoot = false
	var muzzle := gun.get_child(muzzle_idx) as Position2D
	var projectile: Projectile = projectile_type.instantiate()
	projectile.name = "Missile%d" % (muzzle_idx + 1)
	projectile.rotation = -PI / 2
	projectile_container.add_child(projectile, true)
	projectile.start(muzzle.global_position,
			rotation + randf_range(-projectile_spread, projectile_spread),
			projectile_speed, projectile_damage,
			targets.front())
	projectile.collision_mask = detector.collision_mask
	firerate_timer.start(fire_rate)
	muzzle_idx = Global.wrap_index(muzzle_idx + 1, projectile_count)
	# play animation
	_play_animations("shoot_%s" % ["b" if muzzle_idx == 0 else "a"])
	muzzle_flash.global_position = muzzle.global_position
	# show reload time on HUD
	has_shot.emit(firerate_timer.wait_time)
