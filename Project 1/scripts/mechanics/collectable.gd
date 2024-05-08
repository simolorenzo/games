extends Area2D

@export var itemRes: InventoryItem

# This will add the item to the inventory and also eliminate it from the screen
func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()
