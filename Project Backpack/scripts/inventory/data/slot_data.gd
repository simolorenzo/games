class_name SlotData
extends Resource

const MAX_STACK_SIZE: int = 99

@export var item_data: Item
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1
