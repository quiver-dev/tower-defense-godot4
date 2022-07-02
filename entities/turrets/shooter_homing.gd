@tool  # WARN: this appears to be necessary. Investigate further.
extends Shooter


var muzzle_idx := 0  # used to determine which missile to fire


func _ready() -> void:
	super()


func shoot() -> void:
	can_shoot = false
	var muzzle = gun.get_child(muzzle_idx)
	var bullet: Bullet = bullet_type.instantiate()
	bullet.name = "Missile%d" % (muzzle_idx + 1)
	bullet.rotation = -PI / 2
	bullet_container.add_child(bullet, true)
	bullet.start(muzzle.global_position,
			rotation + randf_range(-bullet_spread, bullet_spread),
			targets.front())
	firerate_timer.start(fire_rate)
	muzzle_idx = Global.wrap_index(muzzle_idx + 1, bullet_count)
	# play animation
	gun.play("shoot_%s" % ["b" if muzzle_idx == 0 else "a"])
	# show reload time on HUD
	emit_signal("has_shot", firerate_timer.wait_time)
