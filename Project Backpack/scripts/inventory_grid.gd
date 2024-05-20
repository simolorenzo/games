extends GridContainer

const InventorySlotScene = preload("res://scenes/ui/inventory/parts/slot.tscn") ## Precargamos la escena del slot

func _ready():
	var grid_columns = self.columns
	var total_slots = grid_columns * grid_columns ## Con esto estamos determinando el número de slots que tendrá el grid
	
	## Esto siempre se ejecutará cuando el GridContainer entre
	for i in range(total_slots):
		var slot_instance = InventorySlotScene.instantiate()
		self.add_child(slot_instance)
