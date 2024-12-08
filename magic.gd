extends Node2D


const speed = 100
@export var explody_boom_boom: PackedScene


func _ready() -> void:
	self.position.x += speed * cos(self.rotation)
	self.position.y += speed * sin(self.rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.position.x += speed * cos(self.rotation)
	self.position.y += speed * sin(self.rotation)


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	var boom = explody_boom_boom.instantiate()
	boom.position = self.position
	get_parent().add_child(boom)
	queue_free()
