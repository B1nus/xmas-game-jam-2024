extends CharacterBody2D


const speed: float = 500
@export var sprite: Sprite2D
@export var magic: PackedScene

@export var reload_timer: Timer
var reload_time: float = 1
var has_ball: bool = true

var texture_moving = load('res://images/skogsrå-moving.svg')
var texture_still = load('res://images/skogsrå-still.svg')
var texture_moving_noball = load('res://images/skogsrå-moving-noball.svg')
var texture_still_noball = load('res://images/skogsrå-still-noball.svg')


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		if Input.is_action_pressed("fast"):
			velocity.x = direction * speed * 2
			sprite.offset.y = sin(Time.get_unix_time_from_system() * 24) * 10 - 100
		else:
			velocity.x = direction * speed
			sprite.offset.y = sin(Time.get_unix_time_from_system() * 12) * 15 - 100
		sprite.flip_h = direction > 0
		sprite.offset.x = direction * -300
		if has_ball:
			sprite.texture = texture_moving
		else:
			sprite.texture = texture_moving_noball
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.offset.y = sin(Time.get_unix_time_from_system()) * 25 - 100
		if has_ball:
			sprite.texture = texture_still
		else:
			sprite.texture = texture_still_noball
	
	if Input.is_action_just_pressed("magic") and has_ball:
		has_ball = false
		reload_time += 0.5
		$Timer2.wait_time = 4
		$Timer2.start()
		$Timer.wait_time = reload_time
		$Timer.start()
		var instance = magic.instantiate()
		instance.position = self.position + Vector2(0, 420)
		instance.look_at(get_global_mouse_position())
		get_parent().add_child(instance)

	move_and_slide()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event)
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	has_ball = true

func _on_timer_2_timeout() -> void:
	reload_time = 0
