extends AudioStreamPlayer

@export var start_time: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play(start_time)


func _on_finished() -> void:
	queue_free()
