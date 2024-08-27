extends CharacterBody3D

@export var speed : float = 5.0
@export var mouse_sensitivity : float = 0.1
@export var jump_strength : float = 5.0
var camera : Camera3D = null

func _ready():
	camera = $Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	self.velocity.x = direction.x * speed
	self.velocity.z = direction.z * speed

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		self.velocity.y = jump_strength
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
