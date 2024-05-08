extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	var emptySlots = slots.filter(func(slot): return slot.item == null)
	if !itemSlots.is_empty():
		if itemSlots[0].amount >= item.maxAmount:
			emptySlots[0].item = item
			emptySlots[0].amount = 1
		else:
			itemSlots[0].amount += 1
	else:
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	updated.emit()

func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()

func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
