extends Node2D

@onready var woodpiece_scene = preload("res://Scenes/woodpiece.tscn")
#var unrolled_3x3_array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var unrolled_3x3_array = [0,0,0,0,0,0,0,0,0]
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	print("MAKE NEW STICK")
	#start at top left of rolled array
	for n in range(len(unrolled_3x3_array)):
		if rng.randf() > 0.6:
			unrolled_3x3_array[n] = 1
		else:
			unrolled_3x3_array[n] = 0
	var newstick = Node2D.new()
	add_child(newstick)
	newstick.global_position = Vector2(0, 0)
	var nextpiece_position = Vector2(0, 0)
	var lastpiece = null
	for x in range(len(unrolled_3x3_array)):
		if unrolled_3x3_array[x] == 1:
			var woodpiece = woodpiece_scene.instantiate()
			newstick.add_child(woodpiece)
			if lastpiece != null:
				var joint = DampedSpringJoint2D.new()
				#print(get_node(lastpiece))
				joint.set_node_a(lastpiece)
				joint.set_node_b(woodpiece.get_node_path())
			else:
				lastpiece = woodpiece
		else:
			pass
		if x%3 == 0:
			nextpiece_position += Vector2(0.0, 10.0)
		else:
			nextpiece_position += Vector2(10.0, 0.0)
	newstick.global_position = Vector2(220,100)
	return newstick


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
