extends Area2D

@onready var tile_map = %TileMap

func _on_body_entered(body):
	if body.name == ("Player"):
		tile_map.set_layer_modulate(5, Color(1.0, 1.0, 1.0, 0.3))

func _on_body_exited(body):
	if body.name == ("Player"):
		tile_map.set_layer_modulate(5, Color(1.0, 1.0, 1.0, 1))
