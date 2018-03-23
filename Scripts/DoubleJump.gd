extends Node

onready var k_body = get_node("PlayerBody")
onready var sprite = get_node("PlayerBody/AnimatedSprite")

const gravity = 15
var speed = 150
var jump = false
var jump_max_charges = 2
var jump_charges = 2
var jump_force = 450
var velocity = Vector2(0, 0)
var ground_collisor = []
var grounded = false

func flip():
	if velocity.x == 0:
		pass
	elif velocity.x < 0:
		sprite.scale.x = abs(sprite.scale.x) * -1
	else:
		sprite.scale.x = abs(sprite.scale.x)
	pass

func animate():
	if grounded and velocity.x == 0:
		sprite.play("Idle")
	if grounded and abs(velocity.x) > 0:
		sprite.play("Walk")
	if not grounded and velocity.y < 0:
		sprite.play("Jumping")
	pass

func check_ground():
	if ground_collisor.size() > 0:
		grounded = true
	else:
		grounded = false
	pass

func apply_gravity():
	if not grounded:
		velocity.y += gravity
	if grounded:
		velocity.y = 0
	pass

func get_input():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_just_pressed("ui_jump"):
		jump = true
	pass

func jump(delta):
	if grounded:
		jump_charges = jump_max_charges
	if jump and jump_charges > 0:
		jump_charges -= 1
		velocity.y = 0
		velocity.y -= jump_force
	jump = false
	pass

func _ready():
	pass

func _physics_process(delta):
	check_ground()
	apply_gravity()
	flip()
	jump(delta)
	animate()
	k_body.move_and_slide(velocity)
	velocity.x = 0
	pass

func _process(delta):
	get_input()
	pass

func _on_GroundCollisor_body_entered(body):
	if body.is_in_group("Ground"):
		ground_collisor.append(body)
	pass


func _on_GroundCollisor_body_exited(body):
	if body.is_in_group("Ground"):
		ground_collisor.remove(ground_collisor.find(body))
	pass
