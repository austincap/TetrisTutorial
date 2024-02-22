extends CanvasLayer

class_name UI

@onready var center_container = $CenterContainer
@onready var windscene = preload("res://Scenes/wind.tscn")
@onready var firestarterscene = preload("res://Scenes/firestarter.tscn")
@onready var sapscene = preload("res://Scenes/explosive_sap.tscn")
@onready var firescene = preload("res://Scenes/fire.tscn")
@onready var piece_spawner = preload("res://Scripts/piece_spawner.gd")
@onready var board = preload("res://Scripts/board.gd")
@onready var stickmaker = preload("res://Scenes/stickmaker.tscn")
@onready var woodpiece_scene = preload("res://Scenes/woodpiece.tscn")
var boardinstance = board

var fireButtonPressed = false
var firestarterButtonPressed = false
var sapButtonPressed = false
var windButtonPressed = false

func _input(event):
	if Input.is_action_pressed("click") and fireButtonPressed:
		var fire = firescene.instantiate()
		print(event.as_text())
		fire.position = get_viewport().get_mouse_position()
		print(get_viewport().get_mouse_position())
		add_child(fire)
		fireButtonPressed = false
	if Input.is_action_pressed("click") and firestarterButtonPressed:
		var firestarter = firestarterscene.instantiate()
		print(event.as_text())
		firestarter.position = get_viewport().get_mouse_position()
		print(get_viewport().get_mouse_position())
		add_child(firestarter)
		firestarterButtonPressed = false
	if Input.is_action_pressed("click") and sapButtonPressed:
		var sap = sapscene.instantiate()
		print(event.as_text())
		sap.position = get_viewport().get_mouse_position()
		print(get_viewport().get_mouse_position())
		add_child(sap)
		sapButtonPressed = false
	if Input.is_action_pressed("click") and windButtonPressed:
		var wind = windscene.instantiate()
		wind.position = get_viewport().get_mouse_position()
		var tween = create_tween()
		add_child(wind)
		tween.tween_property(wind, "position:x", 500, 7.0)
		tween.play()
	
func show_game_over():
	center_container.show()


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_windbutton_pressed():
	windButtonPressed = true

func _on_fire_button_pressed():
	fireButtonPressed = true

func _on_firestarter_pressed():
	firestarterButtonPressed = true

func _on_sap_button_pressed():
	sapButtonPressed = true


func _on_stick_button_pressed():
	#var stick = stickmaker.instantiate()
	#add_child(stick)
	var unrolled_3x3_array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	#var unrolled_3x3_array = [0,0,0,0,0,0,0,0,0]
	var arraylength = len(unrolled_3x3_array)
	print(arraylength)
	var rng = RandomNumberGenerator.new()
	print("MAKE NEW STICK")
	#start at top left of rolled array
	for n in range(arraylength):
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
	for x in range(arraylength):
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
			#print("end of row")
			nextpiece_position += Vector2(0.0, 20.0)
			nextpiece_position -= Vector2(20.0, 0.0)*5
		else:
			#print("move right")
			nextpiece_position += Vector2(20.0, 0.0)
	newstick.global_position = Vector2(140,100)

	return newstick



