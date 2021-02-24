extends KinematicBody

export(float, -50, 0) var gravity = -30.0
export(float, 0, 30) var walk_speed = 5.0
export(float, 0, 50) var sprint_speed = 15.0
export(float, 0, 10) var mouse_sensitivity = 4.0 # radians/pixel
export(float, -90, 0) var min_pitch_angle = -45
export(float, 0, 90) var max_pitch_angle = 74

var velocity = Vector3()

onready var camera = $Pivot/Camera
onready var pivot = $Pivot
onready var raycast = $Pivot/RayCast
onready var crosshar_label = $Crosshair/Label

func _ready():
	mouse_sensitivity = mouse_sensitivity/1000
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		pivot.rotation.x = clamp(pivot.rotation.x, deg2rad(min_pitch_angle), deg2rad(max_pitch_angle))

func _physics_process(delta):
	var input_dir = Vector3()
	var speed = walk_speed
	
	if Input.is_action_pressed("move_forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("move_backward"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("move_left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("move_right"):
		input_dir += camera.global_transform.basis.x
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	
	input_dir = input_dir.normalized()
	
	velocity.y += gravity * delta
	var desired_velocity = input_dir * speed

	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

func _process(delta):
	# raycast stuff
	var text = ""
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("MaterialBlock"):
			text = collider.get_parent().name
			#print(":3:", collider.get_parent().name)
	
	crosshar_label.set_text(text)
