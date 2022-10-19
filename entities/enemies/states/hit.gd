extends Motion


@export var state_duration: float = 0.5
@export var slowdown_percentage: float = 0.2  # percentage of diminished speed

var prev_state: State

@onready var timer := Timer.new()
@onready var prev_speed := (owner as Enemy).speed


func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	timer.one_shot = true
	add_child(timer)


# Damage to the owner has already been applied. See parent class.
# We just get the previous state and slow down the enemy
# for the duration of this state
func enter() -> void:
	(owner as Enemy).speed -= int((owner as Enemy).speed * slowdown_percentage)
	prev_state = (owner as Enemy).state_machine.states_stack.back()
	timer.start(state_duration)


# Restore original speed
func exit() -> void:
	timer.stop()
	(owner as Enemy).speed = prev_speed


func update(_delta: float) -> void:
	if prev_state is Motion:
		_move()


# We actually have a stack of states that lets us see the previous one.
# In this case we can use it to restore the state the owner was in
# before entering this one.
func _on_Timer_timeout() -> void:
	finished.emit((prev_state.name as String).to_lower())
