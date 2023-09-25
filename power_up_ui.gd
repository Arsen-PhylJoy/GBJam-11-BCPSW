extends Control

@export var player: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	check_current()
	check_next()

func check_current()-> void:
	if(player.power_up == null):
		$BigPowerUpIconCurrent.hide()
		$ShieldPowerUpIconCurrent.hide()
		$SmallPowerUpIconCurrent.hide()
	elif player.power_up.type == Global.PowerUp.BIG:
		$BigPowerUpIconCurrent.show()
		$ShieldPowerUpIconCurrent.hide()
		$SmallPowerUpIconCurrent.hide()
	elif player.power_up.type == Global.PowerUp.SMALL:
		$BigPowerUpIconCurrent.hide()
		$SmallPowerUpIconCurrent.show()
		$ShieldPowerUpIconCurrent.hide()
	elif player.power_up.type == Global.PowerUp.SHIELD:
		$BigPowerUpIconCurrent.hide()
		$SmallPowerUpIconCurrent.hide()
		$ShieldPowerUpIconCurrent.show()

func check_next()-> void:
	if(player.power_up_stash == null):
		$BigPowerUpIconNext.hide()
		$ShieldPowerUpIconNext.hide()
		$SmallPowerUpIconNext.hide()
	elif player.power_up_stash.type == Global.PowerUp.BIG:
		$BigPowerUpIconNext.show()
		$ShieldPowerUpIconNext.hide()
		$SmallPowerUpIconNext.hide()
	elif player.power_up_stash.type == Global.PowerUp.SMALL:
		$BigPowerUpIconNext.hide()
		$SmallPowerUpIconNext.show()
		$ShieldPowerUpIconNext.hide()
	elif player.power_up_stash.type == Global.PowerUp.SHIELD:
		$BigPowerUpIconNext.hide()
		$SmallPowerUpIconNext.hide()
		$ShieldPowerUpIconNext.show()
