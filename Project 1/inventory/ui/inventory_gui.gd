extends Control
## This scripts manages the general overview of the inventory
## and makes it interactable

signal opened
signal closed

var isOpen: bool = false ## Tracks if inventory is open or closed
var itemInHand: ItemStackGui ## Variable to hold the currently grab item

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://scenes/ui/item_stack_gui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

## Called when the script is loaded the first time
func _ready():
	connectSlots()
	inventory.updated.connect(update) ## Connects "update" signal to inventory reference
	update() ## Updates the inventory GUI at the start

## Connects click events from inventory slots to onSlotClicked function
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(onSlotClicked) ## Create a callable object referencing onSlotClicked function
		callable = callable.bind(slot) ## Bind the callable to the specific slot for proper context
		slot.pressed.connect(callable) ## Connect the slot's pressed signal to the callable object

## Updates the UI to reflect the current inventory state
func update():
	## Loop through the minimum of inventory slots and UI slots
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()


# Open inventory
func open():
	visible = true
	isOpen = true
	opened.emit()

# Close inventory
func close():
	visible = false
	isOpen = false
	closed.emit()


func onSlotClicked(slot):
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return
	
	if !itemInHand:
		takeItemFromSlot(slot)

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()

func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2

func _input(event):
	updateItemInHand()
