extends Node
var fireoxygenation = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fire_adjacent_area_area_entered(area):
	if area.is_in_group("wind"):
		print("wind consumed by fire")
		fireoxygenation += 1
		area.windpower -= 1




func _on_fire_adjacent_area_area_exited(area):
	if area.is_in_group("wind"):
		print("wind consumed by fire")
		fireoxygenation += 1
		area.windpower -= 1
	elif area.is_in_group("wood"):
		pass


func _on_fire_adjacent_area_body_entered(body):
	if body.is_in_group("wood"):
		body.set_meta("onfire", true)
		print("wood is on fire")
		get_tree().get_root().get_node("firemakermain").wood_array.append(body)
