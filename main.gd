extends Node2D

@export var nightbutton: Button
@export var forest_music: AudioStreamPlayer
@export var daytime_music: AudioStreamPlayer
@export var night_music: AudioStreamPlayer
@export var background: TextureRect
@export var ground: TextureRect
@onready var daytime_texture = load("res://images/background-daytime.svg")
@onready var nighttime_texture = load("res://images/background-nighttime.svg")

var nighttime: bool = false
@export var night_timer: Timer
@export var ant_timer: Timer
@export var ant: PackedScene

var night: int = 0
var health = 50


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	daytime()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	forest_music.playing = false
	daytime_music.playing = false
	night_music.play(2)
	background.texture = nighttime_texture
	ground.modulate = Color(0.5,0.5,0.5,1)
	nightbutton.visible = false
	nighttime = true
	night_timer.wait_time = 30
	night_timer.start()
	night += 1
	health = 50

func daytime() -> void:
	nighttime = false
	forest_music.playing = true
	daytime_music.playing = true
	night_music.playing = false
	background.texture = daytime_texture
	ground.modulate = Color(1,1,1,1)
	nightbutton.visible = true
	for child in get_children():
		if child is CharacterBody2D and child.name != "CharacterBody2D":
			child.die()


func _on_timer_timeout() -> void:
	if nighttime:
		$Timer.wait_time = ((randi() % 2) * 0.9 + 0.1) * 5 / pow(night, 2)
		var new_ant = ant.instantiate()
		var rand_one = (randi() % 2) * 2 - 1
		new_ant.position = Vector2(1152 / 2 + rand_one * 1200, 800)
		add_child(new_ant)


func _on_timer_2_timeout() -> void:
	daytime()

func hurt() -> void:
	health -= 1
	if health < 0:
		get_tree().reload_current_scene()
	$AnimationPlayer.play("hurt")
