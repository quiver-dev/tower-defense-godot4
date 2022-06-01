class_name Tank
extends Enemy


@onready var shooter: Shooter = $Shooter


func _ready() -> void:
	# WARN: this is a workaround, see https://github.com/godotengine/godot/issues/60168
	super._ready()


# Checks if there are other tanks ahead
func is_raycast_colliding() -> bool:
	for raycast in [$LookAhead1, $LookAhead2]:
		if (raycast as RayCast2D).is_colliding() and \
				(raycast as RayCast2D).get_collider() is Tank:
			return true
	return false
