@tool  # WARN: this appears to be necessary. Investigate further.
extends Shooter


var muzzle_idx := 0  # used to determine which missile to fire


func _ready() -> void:
	super()


func shoot() -> void:
	can_shoot = false
	var muzzle = gun.get_child(muzzle_idx)
	var projectile: Projectile = projectile_type.instantiate()
	projectile.name = "Missile%d" % (muzzle_idx + 1)
	projectile.rotation = -PI / 2
	projectile_container.add_child(projectile, true)
	projectile.start(muzzle.global_position,
			rotation + randf_range(-projectile_spread, projectile_spread),
			targets.front())
	firerate_timer.start(fire_rate)
	muzzle_idx = Global.wrap_index(muzzle_idx + 1, projectile_count)
	# play animation
	gun.play("shoot_%s" % ["b" if muzzle_idx == 0 else "a"])
	# show reload time on HUD
	emit_signal("has_shot", firerate_timer.wait_time)
