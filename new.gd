extends Button

@onready var root = $"../.."
@onready var animP = $"../../AnimationPlayer"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Hide and capture the mouse
	root.queue_free()


func _on_mouse_entered() -> void:
	animP.play("hover")


func _on_mouse_exited() -> void:
	animP.play("RESET")
