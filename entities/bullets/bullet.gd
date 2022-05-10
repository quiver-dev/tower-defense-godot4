class_name Bullet
extends Area2D
# This class extends the Area2D node because we don't need advanced
# physics or player-controlled movement.
# It also uses a VisibleOnScreenEnabler2D node to automatically
# disable this scene when the bullet exits the screen.
# WARN: this is probably not optimal due to the presence of a camera


@export var speed: int = 1000
@export var damage: int = 10

var velocity: Vector2


func _physics_process(delta: float) -> void:
	global_position += velocity * delta


# Called by the turret, which instantiates a bullet and gives it a target
func start(_position: Vector2, _rotation: float) -> void:
	global_position = _position
	rotation = _rotation
	velocity = Vector2.RIGHT.rotated(_rotation) * speed


func _on_bullet_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.take_damage(damage)
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	print("Freeing ", self.name)
	queue_free()
