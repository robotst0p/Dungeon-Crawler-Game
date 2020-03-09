extends Node

var commands_list = { "quit" : funcref(self, "quit"),
					  "help" : funcref(self, "help") }

var entered_commands = Array()
var open = false

func _input(event):
	if event.is_action_pressed("OpenConsole"):
		event.unicode = SPKEY # so nothing is input to $LineEdit
		toggle_console()
	elif open and event.is_action_pressed("Enter"):
		enter_command($LineEdit.text)
		
func toggle_console():
	if open:
		get_tree().paused = false
		open = false
		$LineEdit.visible = false
		$LineEdit.pause_mode = Node.PAUSE_MODE_STOP
	else:
		get_tree().paused = true
		open = true
		$LineEdit.visible = true
		$LineEdit.pause_mode = Node.PAUSE_MODE_PROCESS
		$LineEdit.grab_focus()
		$LineEdit.clear()
		print_entered_commands()
		
func print_entered_commands():
	print("Entered Commands: ")
	for command in entered_commands:
		print(command)
		
func quit():
	get_tree().quit()
	
func help():
	print("List of valid commands: ")
	for command in commands_list.keys():
		print(command)

func enter_command(command: String) -> void:
	entered_commands.push_back(command)
	
	if (commands_list.has(command)):
		commands_list[command].call_func()
	else:
		print("Invalid command.")
		
	$LineEdit.clear()
	print_entered_commands()
