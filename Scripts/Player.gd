extends Node2D

export var speed = 250
export var jump_force = -1000
export var gravity = 400
onready var k_body = get_node("PlayerBody")
onready var sprite = get_node("PlayerBody/AnimatedSprite")
var velocity = Vector2(0, 0)
enum JUMP_TYPE { megaman, mario, sonic}
var jump_type = megaman
var jump_timer = 0

func _ready():
	
	pass

func flip(vel_x):
	if vel_x == 0:
		pass
	elif vel_x < 0:
		sprite.scale.x = abs(sprite.scale.x) * -1
	else:
		sprite.scale.x = abs(sprite.scale.x) 
	pass

func megaman_jump(delta):
	if velocity.y <= 0:
		velocity.y += gravity
	if Input.is_action_pressed("ui_jump") and jump_timer <= 0.3:
		jump_timer += delta
		velocity.y += jump_force
	pass

func mario_jump():
	pass

func sonic_jump():
	pass

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	match jump_type:
			JUMP_TYPE.megaman:
				megaman_jump(delta)
			JUMP_TYPE.mario:
				mario_jump()
			JUMP_TYPE.sonic:
				sonic_jump()
	flip(velocity.x)
	k_body.move_and_slide(velocity)
	pass

func _on_GroundCollisor_body_entered(body):
	if body.is_in_group("Ground"):
		match jump_type:
			JUMP_TYPE.megaman:
				jump_timer = 0
	pass


func _on_GroundCollisor_body_exited(body):
	pass # replace with function body
