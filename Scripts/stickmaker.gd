extends Node2D

@onready var woodpiece_scene = preload("res://Scenes/woodpiece.tscn")
var unrolled_3x3_array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
#var unrolled_3x3_array = [0,0,0,0,0,0,0,0,0]
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
var count = 0
func _ready():
	print("MAKE NEW STICK")
	#start at top left of rolled array
	for n in range(len(unrolled_3x3_array)):
		if rng.randf() > 0.4:
			unrolled_3x3_array[n] = 1
		else:
			unrolled_3x3_array[n] = 0
	#var newstick = Node2D.new()
	var newstick = Skeleton2D.new()
	add_child(newstick)
	newstick.global_position = Vector2(0, 0)
	var nextpiece_position = Vector2(0, 0)
	var lastpiece = null
	for x in range(len(unrolled_3x3_array)):
		if unrolled_3x3_array[x] == 1:
			var woodpiece = woodpiece_scene.instantiate()
			woodpiece.global_position = nextpiece_position
			newstick.add_child(woodpiece)

			
			#newstick.global_position = nextpiece_position
			if lastpiece != null:
				#var joint = DampedSpringJoint2D.new()
				var joint = PinJoint2D.new()
				add_child(joint)
				#joint.damping = 0.1
				#joint.length = 20.0
				#joint.rest_length = 10.0
				#joint.stiffness = 20.0
				#joint.global_position = nextpiece_position
				#joint.set_angular_limit_enabled ( true )
				#joint.angular_limit_lower = 20.0
				#joint.angular_limit_upper = 60.0
				#joint.softness = 0.5
				#joint.length = 30
				joint.disable_collision = true
				joint.set_node_a(lastpiece.get_path())
				joint.set_node_b(woodpiece.get_path())
			else:
				lastpiece = woodpiece
		else:
			pass
		if (((x+1)%5) == 0):
			print("end of row")
			nextpiece_position += Vector2(0.0, 20.0)
			nextpiece_position -= Vector2(20.0, 0.0)*5
		else:
			print("move right")
			nextpiece_position += Vector2(20.0, 0.0)
	newstick.global_position = Vector2(0,0)
	return newstick


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
