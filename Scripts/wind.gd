extends Area2D
var windpower = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (windpower <= 0) or (get_meta("windpower") <= 0):
		queue_free()
