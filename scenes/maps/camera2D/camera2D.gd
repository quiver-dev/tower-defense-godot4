extends Camera2D
# Panning camera which can be zoomed out/in with the mouse wheel and panned by
# holding the middle mouse button and dragging the mouse.
# We use _physics_process to animate the zoom and to make sure the zooming
# speed is not influenced by the framerate, since it's always updated at 60 FPS.


@export var min_zoom: float = 0.25
@export var max_zoom: float = 1.0
@export var zoom_rate: float = 16.0
@export var zoom_delta: float = 0.1
@export var drag_speed: float = 4.0

@onready var target_zoom: float = zoom.x  # this assignment is just for initialization
@onready var hud := $Hud as Hud


func _physics_process(delta: float) -> void:
	zoom.x = lerp(zoom.x, target_zoom, zoom_rate * delta)
	zoom.y = lerp(zoom.y, target_zoom, zoom_rate * delta)
	# disable physics process when zoom has reached its target
	set_physics_process(not is_equal_approx(zoom.x, target_zoom))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in()
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out()
	if event is InputEventMouseMotion and \
			event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
		# go the opposite direction of the dragging and multiply the current
		# zoom to regulate the dragging speed
		position -= event.relative * drag_speed * zoom 
	# apply custom mouse cursor by mapping middle mouse button in the InputMap
	if event.is_action_pressed("middle_mouse"):
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	if event.is_action_released("middle_mouse"):
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func zoom_in() -> void:
	target_zoom = min(target_zoom + zoom_delta, max_zoom)
	set_physics_process(true)


func zoom_out() -> void:
	target_zoom = max(target_zoom - zoom_delta, min_zoom)
	set_physics_process(true)
