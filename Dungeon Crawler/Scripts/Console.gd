extends Node

var commands_list = { "quit" : funcref(self, "quit"),
					  "help" : funcref(self, "help") }

var entered_commands = Array()
var open = false

func _ready():
	open = true
	toggle_console()
	$RichTextLabel.clear()

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
		$RichTextLabel.visible = false
		$LineEdit.visible = false
		$LineEdit.pause_mode = Node.PAUSE_MODE_STOP
	else:
		get_tree().paused = true
		open = true
		$RichTextLabel.visible = true
		$LineEdit.visible = true
		$LineEdit.pause_mode = Node.PAUSE_MODE_PROCESS
		$LineEdit.grab_focus()
		$LineEdit.clear()
		
func quit():
	get_tree().quit()
	
func help():
	$RichTextLabel.add_text("List of valid commands: \n")
	for command in commands_list.keys():
		$RichTextLabel.add_text(str(command, '\n'))

func enter_command(command: String) -> void:
	entered_commands.push_back(command)
	
	$LineEdit.clear()
	
	if (commands_list.has(command)):
		commands_list[command].call_func()
	else:
		$RichTextLabel.add_text(str("Unknown command \"", command, "\"\n"))
