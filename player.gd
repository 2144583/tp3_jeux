extends CharacterBody2D

var UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 100
const JUMPFORCE = 300
const ACCEL = 10


var facing_right = true
var motion = Vector2()

# Get references to the nodes in _ready()
var currentSprite
var animPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	currentSprite = $Sprite
	animPlayer = $AnimationPlayer

func _physics_process(_delta):
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED

	currentSprite.flip_h = not facing_right

	if Input.is_action_pressed("left"):
		velocity.x -= ACCEL
		facing_right = false
		animPlayer.play("Run")
	elif Input.is_action_pressed("right"):
		velocity.x += ACCEL
		facing_right = true
		animPlayer.play("Run")
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)
		animPlayer.play("Idle")

	velocity.x = clamp(velocity.x, -MAXSPEED, MAXSPEED)

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMPFORCE

	if not is_on_floor():
		if velocity.y < 0:
			animPlayer.play("jump")
		elif velocity.y > 0:
			animPlayer.play("fall")
		else:
			animPlayer.play("idle")

	move_and_slide()
