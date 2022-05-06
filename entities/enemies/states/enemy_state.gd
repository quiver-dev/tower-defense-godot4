class_name EnemyState
extends State


# Called when colliding with damaging objects. This is a limitation of
# this implementation because we can't pass data directly to the hit state.
# TODO: check if it's better to move this to the state machine,
# or (even better) find a way to let the Hit state handle damage.
func is_hit(damage: int) -> void:
	if (owner as Enemy).get_fsm().current_state.name == "Hit":
		print("Already in Hit state")
		return
	(owner as Enemy).take_damage(damage)
	emit_signal("finished", "hit")
