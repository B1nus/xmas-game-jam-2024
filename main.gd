extends Node2D

@export var nightbutton: Button
@export var background: TextureRect
@export var ground: TextureRect
@onready var daytime_texture = load("res://images/background-daytime.svg")
@onready var nighttime_texture = load("res://images/background-nighttime.svg")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	background.texture = nighttime_texture
	ground.modulate = Color(0.35,0.35,0.35,1)
	nightbutton.visible = !nightbutton.visible

func daytime() -> void:
	background.texture = daytime_texture
	ground.modulate = Color(1,1,1,1)
	nightbutton.visible = true
