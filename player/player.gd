extends KinematicBody2D

class_name Player


const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 480
const SIDING_CHANGE_SPEED = 10
const SHOOT_TIME_SHOW_WEAPON = 0.2

var linear_vel = Vector2()
var shoot_time = 99999 # time since last shot

var has_gun = false
var has_seeds = false
var has_tools = false
var wood_count = 0
var trees_grown = 0

var anim = ""

# cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $Sprite

var Bullet = preload("res://player/Bullet.tscn")
var Seed = preload("res://player/Seed.tscn")
var Cut = preload("res://player/Cut.tscn")
var Tool = preload("res://player/Tool.tscn")

const BULLET_VELOCITY = 1000
const SEED_VELOCITY = 100

func pickup(item):
	if item == "Seeds":
		has_seeds = true
	elif item == "Gun":
		has_gun = true
	elif item == "Tools":
		has_tools = true
	elif item == "Wood":
		wood_count += 1

func grow_tree():
	trees_grown += 1

func _physics_process(delta):
	# Increment counters
	shoot_time += delta

	### MOVEMENT ###

	# Apply gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect if we are on floor - only works if called *after* move_and_slide
	var on_floor = is_on_floor()

	### CONTROL ###

	# Horizontal movement
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed -= 1
	if Input.is_action_pressed("move_right"):
		target_speed += 1

	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Jumping
	if on_floor and Input.is_action_just_pressed("jump"):
		linear_vel.y = -JUMP_SPEED
		($SoundJump as AudioStreamPlayer2D).play()

	# Shooting
	if has_gun and Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instance()
		bullet.position = ($Sprite/BulletShoot as Position2D).global_position # use node for shoot position
		bullet.linear_velocity = Vector2(($Sprite as Sprite).scale.x * BULLET_VELOCITY, 0)
		bullet.add_collision_exception_with(self) # don't want player to collide with bullet
		get_parent().add_child(bullet) # don't want bullet to move with me, so add it as child of parent
		($SoundShoot as AudioStreamPlayer2D).play()
		shoot_time = 0
	elif has_seeds and Input.is_action_just_pressed("plant"):
		var seeds = Seed.instance()
		seeds.position = ($Sprite/BulletShoot as Position2D).global_position # use node for shoot position
		seeds.linear_velocity = Vector2(($Sprite as Sprite).scale.x * SEED_VELOCITY, 0)
		seeds.add_collision_exception_with(self) # don't want player to collide with seed
		get_parent().add_child(seeds) # don't want seeds to move with me, so add it as child of parent
		shoot_time = 0
	elif has_tools and Input.is_action_just_pressed("cut"):
		var cut = Cut.instance()
		cut.position = ($Sprite/BulletShoot as Position2D).global_position
		cut.linear_velocity = Vector2(($Sprite as Sprite).scale.x * 100, 0)
		cut.add_collision_exception_with(self) # don't want player to collide with cutting
		get_parent().add_child(cut)
		shoot_time = 0
	elif has_tools and Input.is_action_just_pressed("repair"):
		var tools = Tool.instance()
		tools.position = ($Sprite/BulletShoot as Position2D).global_position
		tools.linear_velocity = Vector2(($Sprite as Sprite).scale.x * 100, 0)
		tools.add_collision_exception_with(self) # don't want player to collide with tools
		get_parent().add_child(tools) 
		shoot_time = 0

	### ANIMATION ###

	var new_anim = "idle"

	if on_floor:
		if linear_vel.x < -SIDING_CHANGE_SPEED:
			sprite.scale.x = -1
			new_anim = "run"

		if linear_vel.x > SIDING_CHANGE_SPEED:
			sprite.scale.x = 1
			new_anim = "run"
	else:
		# We want the character to immediately change facing side when the player
		# tries to change direction, during air control.
		# This allows for example the player to shoot quickly left then right.
		if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			sprite.scale.x = -1
		if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			sprite.scale.x = 1

		if linear_vel.y < 0:
			new_anim = "jumping"
		else:
			new_anim = "falling"

	if shoot_time < SHOOT_TIME_SHOW_WEAPON:
		new_anim += "_weapon"

	if new_anim != anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)
