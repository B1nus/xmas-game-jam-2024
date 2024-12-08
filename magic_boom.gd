extends GPUParticles2D

@export var explody_area: Area2D

func _ready() -> void:
	self.emitting = true

func _on_timer_timeout() -> void:
	queue_free()


func _on_timer_2_timeout() -> void:
	$Area2D.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.die()
