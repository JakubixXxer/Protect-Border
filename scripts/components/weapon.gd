extends Node

class_name Weapon

var weapons := {"Pistol": "res://scenes/weapons/pistol.tscn"}
var activeWeapon: String

# This function gives weapon to player on HandSocket Node
func give_weapon(weaponPath: String):
	var weaponScene = load(weaponPath).instantiate()
	
	var socket = get_node_or_null("HandSocket")
	if socket:
		socket.add_child(weaponScene)
		activeWeapon = weaponPath
	else:
		print("There is no socket to create a child of weapon")

# To delete probably
func get_active_weapon() -> String:
	return activeWeapon
