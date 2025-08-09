extends CharacterBody2D


const SPEED := 100.0
const JUMP_VELOCITY := -400.0

var setup_done: bool = false
var level_size: Vector2i = Vector2i.ZERO


func setup(level_size: Vector2i) -> void:
	self.level_size = level_size
	setup_done = true


func _ready() -> void:
	assert(setup_done, "Call setup() before using this class.")
	calc_pos()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	
func calc_pos() -> void:
	# Calculate the position of the player based on the level size.
	if not setup_done:
		return
	
	var x := level_size.x / 2
	var y := level_size.y / 2
	position = Vector2(x, y)