extends Spatial

export var always_on_top = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.set_window_always_on_top(always_on_top)

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
