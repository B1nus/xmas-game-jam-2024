extends CharacterBody2D


const speed: float = 500
@export var sprite: Sprite2D

var texture_moving = load('res://images/skogsrå-moving.svg')
var texture_still = load('res://images/skogsrå-still.svg')


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		sprite.flip_h = direction > 0
		sprite.offset.x = direction * -150
		sprite.texture = texture_moving
		sprite.offset.y = sin(Time.get_unix_time_from_system() * 12) * 15 - 100
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.texture = texture_still
		sprite.offset.y = sin(Time.get_unix_time_from_system()) * 25 - 100

	move_and_slide()
