extends Node
var firehotness = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fire_adjacent_area_area_entered(area):
	if area.is_in_group("wind"):
		print("wind consumed by fire")
		firehotness += 1
		area.windpower -= 1


func _on_fire_adjacent_area_area_exited(area):
	if area.is_in_group("wind"):
		print("wind consumed by fire")
		firehotness += 1
		area.windpower -= 2
