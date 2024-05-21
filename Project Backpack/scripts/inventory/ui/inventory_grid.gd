extends PanelContainer

const SlotScene = preload("res://scenes/ui/inventory/parts/slot.tscn") ## Precargamos la escena del slot
const ItemScene = preload("res://scenes/ui/inventory/parts/slot_item.tscn")

@onready var grid_slots = $GridSlots
@onready var grid_items = $GridItems

@export var inventory_data: InventoryData

func _ready():
	var slots_columns = grid_slots.columns
	grid_items.columns = slots_columns
	var total_slots = slots_columns * slots_columns ## Con esto estamos determinando el número de slots que tendrá el grid
	
	## Esto siempre se ejecutará cuando el GridContainer entre
	for i in range(total_slots):
		var slot_instance = SlotScene.instantiate()
		grid_slots.add_child(slot_instance)
	
	for item in inventory_data.slot_datas:
		if item == null:
			pass
		else:
			add_item(item)
	
func add_item(new_item_data: SlotData):
	var item_instance = ItemScene.instantiate()
	grid_items.add_child(item_instance)
	
	var item_icon = item_instance.get_node("Icon")
	item_icon.texture = new_item_data.item_data.icon
