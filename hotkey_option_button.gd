extends OptionButton

var listening = false
var actions_array = ["hiImsteveandimheretopreventoffbyone"]

func _input(event):
	if listening and event is InputEventKey and event.pressed:
		listening=false
		var t = actions_array[selected]
		InputMap.action_erase_events(t)
		InputMap.action_add_event(t,event)
		set_item_text(selected,t+str(InputMap.get_action_list(t)[0]))
		$popup.visible=false
		selected=0

func item_selected(index):
	$popup.popup_centered()
	listening=true

func _ready():
	for item in InputMap.get_actions():
		if not "ui" in item:
			add_item(item+str(InputMap.get_action_list(item)[0]))
			actions_array.append(item)

