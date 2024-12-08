extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.playing = true

func _process(delta: float) -> void:
	self.volume_db -= 20 * delta


func _on_finished() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	self.playing = true
	$Timer.queue_free()
