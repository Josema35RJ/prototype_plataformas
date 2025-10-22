extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 600.0
const DASH_DURATION = 0.2

var dash_timer := 0.0

func _ready():
	add_to_group("Player")
	await get_tree().process_frame


func _physics_process(delta):
	aplicar_gravedad(delta)
	controlar_movimiento()
	controlar_salto()
	move_and_slide()


func aplicar_gravedad(delta):
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta

func controlar_salto():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

func controlar_movimiento():
	var direction = Input.get_axis("move_left", "move_right")
	animated_sprite.flip_h = direction > 0
	velocity.x = direction * SPEED
	
func actualizar_animacion():

	if velocity.x == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Walk")
		
