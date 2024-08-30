extends Area3D

@onready var animP = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	animP.play("visible")
	print("entered")


func _on_body_exited(body: Node3D) -> void:
	animP.play("RESET")
	print("exited")
