extends Node2D



func _ready():
	add_to_group('persist')
	$"CanvasLayer/filter".set_modulate( Color( 1 , 1 , 1 , .85 ) )
	for i in $'CanvasLayer'.get_children():
		if i.get_index() >= 10 and i.get_index() <= 16:
			i.connect('pressed', self, '_on_'+i.name+'_pressed')



func _process(delta):
	repair()
	for i in $'CanvasLayer'.get_children():
		if i.get_index() >= 3 and i.get_index() <= 9:
			i.set_value(upgrades.vars[i.name + 'Lvl'] * 10)
		if i.get_index() >= 17 and i.get_index() < 24:
			var accName = ''
			for j in i.name.length():
				if j < i.name.length() - 4:
					accName += i.name[j]
			
			if upgrades.vars[accName + 'Lvl'] == 10:
				i.set_text('MAX')
			else:
				i.set_text('E' + str(upgrades.costs[i.name]))



func _on_x_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		$'guiExit'.play()
		for i in $'CanvasLayer'.get_children():
			i.hide()
		get_parent().get_parent().get_node('Controls').set_process(true)



func _on_shipHealthU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.shipHealthCost and upgrades.vars.shipHealthLvl < 10:
		plVars.vars.energy -= upgrades.costs.shipHealthCost
		upgrades.vars.shipHealthLvl += 1
		upgrades.costs.shipHealthCost *= 1.5
		upgrades.costs.shipHealthCost = int(round(upgrades.costs.shipHealthCost))
		plVars.vars.shipHealth *= 1.25


func _on_shipSpeedU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.shipSpeedCost and upgrades.vars.shipSpeedLvl < 10:
		plVars.vars.energy -= upgrades.costs.shipSpeedCost
		upgrades.vars.shipSpeedLvl += 1
		upgrades.costs.shipSpeedCost *= 1.5
		upgrades.costs.shipSpeedCost = int(round(upgrades.costs.shipSpeedCost))
		plVars.vars.shipSpeed *= 1.25



func _on_fuelConsumptionU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.fuelConsumptionCost and upgrades.vars.fuelConsumptionLvl < 10:
		plVars.vars.energy -= upgrades.costs.fuelConsumptionCost
		upgrades.vars.fuelConsumptionLvl += 1
		upgrades.costs.fuelConsumptionCost *= 1.5
		upgrades.costs.fuelConsumptionCost = int(round(upgrades.costs.fuelConsumptionCost))
		plVars.vars.fuelConsumption -= plVars.vars.fuelConsumption * .25



func _on_rotationSpeedU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.rotationSpeedCost and upgrades.vars.rotationSpeedLvl < 10:
		plVars.vars.energy -= upgrades.costs.rotationSpeedCost
		upgrades.vars.rotationSpeedLvl += 1
		upgrades.costs.rotationSpeedCost *= 1.5
		upgrades.costs.rotationSpeedCost = int(round(upgrades.costs.rotationSpeedCost))
		plVars.vars.rotationSpeed *= 1.10



func _on_bulletDamageU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.bulletDamageCost and upgrades.vars.bulletDamageLvl < 10:
		plVars.vars.energy -= upgrades.costs.bulletDamageCost
		upgrades.vars.bulletDamageLvl += 1
		upgrades.costs.bulletDamageCost *= 1.5
		upgrades.costs.bulletDamageCost = int(round(upgrades.costs.bulletDamageCost))
		plVars.vars.bulletDamage *= 1.25



func _on_bulletSpeedU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.bulletSpeedCost and upgrades.vars.bulletSpeedLvl < 10:
		plVars.vars.energy -= upgrades.costs.bulletSpeedCost
		upgrades.vars.bulletSpeedLvl += 1
		upgrades.costs.bulletSpeedCost *= 1.5
		upgrades.costs.bulletSpeedCost = int(round(upgrades.costs.bulletSpeedCost))
		plVars.vars.bulletSpeed *= 1.25



func _on_reloadTimeU_pressed():
	$'guiClick'.play()
	if plVars.vars.energy >= upgrades.costs.reloadTimeCost and upgrades.vars.reloadTimeLvl < 10:
		plVars.vars.energy -= upgrades.costs.reloadTimeCost
		upgrades.vars.reloadTimeLvl += 1
		upgrades.costs.reloadTimeCost *= 1.5
		upgrades.costs.reloadTimeCost = int(round(upgrades.costs.reloadTimeCost))
		plVars.vars.reloadTime -= plVars.vars.reloadTime * .25



func save():
	var dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'Name': self.name,
		'pos_x': self.position.x,
		'pos_y': self.position.y
	}
	return dict



func _on_toggleDarkUp_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		$'CanvasLayer/repairBack'.show()
		$'CanvasLayer/repairCost'.show()
		$'guiClick'.play()
		for i in $'CanvasLayer'.get_children():
			if i.name == 'filter' or i.name == 'x' or i.name == 'toggleDarkRe' or i.name == 'toggleBrightRe' or i.name == 'repairBack' or i.name == 'repairCost' or i.name == 'repair':
				i.show()
			else:
				i.hide()



func _on_toggleDarkRe_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		$'guiClick'.play()
		for i in $'CanvasLayer'.get_children():
			if i.get_index() >= 0 and i.get_index() < 26:
				i.show()
			else:
				i.hide()



func repair():
	plVars.vars.repairCost = int(ceil(plVars.vars.shipMaxHealth - plVars.vars.shipHealth)) * 10
	
	$'CanvasLayer/repairCost'.set_text('E'+ str(plVars.vars.repairCost))



func _on_repair_pressed():
	$'guiClick'.play()
	if plVars.vars.repairCost <= plVars.vars.energy:
		plVars.vars.energy -= plVars.vars.repairCost
		plVars.vars.shipHealth = plVars.vars.shipMaxHealth
