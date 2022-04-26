extends Camera2D
# Panning camera which can be zoomed out/in with the mouse wheel and panned by
# holding the middle mouse button and dragging the mouse.
# We use the _physics_process to animate the zoom and to make sure the zooming
# speed is not influenced by the framerate, since it always updated at 60 FPS.


const MIN_ZOOM: float = 0.1
const MAX_ZOOM: float = 1.0
const ZOOM_RATE: float = 8.0
const ZOOM_INCREMENT: float = 0.1

var target_zoom: float = 1.0


func _physics_process(delta: float) -> void:
	zoom.x = lerp(zoom.x, target_zoom, ZOOM_RATE * delta)
	zoom.y = lerp(zoom.y, target_zoom, ZOOM_RATE * delta)
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
		position -= event.relative * zoom


func zoom_in() -> void:
	target_zoom = max(target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)


func zoom_out() -> void:
	target_zoom = min(target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
	set_physics_process(true)
