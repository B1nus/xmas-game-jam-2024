extends CharacterBody2D


const SPEED = 300.0

func _ready() -> void:
	$AnimatedSprite2D.flip_h = self.position.x > 0

var mem_pos = self.position
@export var knock_wood_sound: PackedScene
@export var knock_wood_particles: PackedScene
@export var ant_boom: PackedScene
@export var pop_sound: PackedScene
@export var splatt_sound: PackedScene

func _physics_process(delta: float) -> void:
	var direction := - signi(self.position.x - 1152 / 2 - 100)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if abs(mem_pos.x - self.position.x) < 4 and self.position.y > 450:
		self.position.y -= 5
	mem_pos = self.position

	move_and_slide()


func _on_timer_timeout() -> void:
	if abs(self.position.x - 1152 / 2 - 100) < 150:
		get_parent().hurt()
		get_parent().add_child(knock_wood_sound.instantiate())
		var particles = knock_wood_particles.instantiate()
		particles.position = self.position
		get_parent().add_child(particles)
		$AnimationPlayer.play("hurt")

func die() -> void:
	var new_ant_boom = ant_boom.instantiate()
	new_ant_boom.position = self.position
	get_parent().add_child(new_ant_boom)
	get_parent().add_child(splatt_sound.instantiate())
	get_parent().add_child(pop_sound.instantiate())
	self.queue_free()
