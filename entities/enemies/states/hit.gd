extends EnemyState


const DURATION := 0.8

@onready var timer := Timer.new()


func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	timer.one_shot = true
	add_child(timer)


# Damage to the owner has already been applied. See parent class.
func enter() -> void:
	timer.start(DURATION)


func exit() -> void:
	timer.stop()


# We actually have a stack of states that lets us see the previous one.
# In this case we can use it to restore the state the owner was in
# before entering this one.
func _on_Timer_timeout() -> void:
	var prev_state: String = (owner as Enemy).get_fsm().states_stack.back().name
	emit_signal("finished", prev_state.to_lower())
