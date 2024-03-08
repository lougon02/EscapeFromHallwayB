extends CanvasLayer

@onready var jump_label : Label = $Jump/JumpContainer/Label
@onready var flip_label : Label = $Flip/FlipContainer/Label
@onready var weight_label : Label = $Weight/WeightContainer/Label

@onready var countdown_label : Label = $CountDown/CountDownLabel
@onready var countdown_timer = $CountDown/CountDownTimer

var target_path = preload("res://assets/cursors/target.png")
var area_cursor = preload("res://assets/cursors/area_cursor.png")

var isSingleTarget = true
var selectedPowerup = null

# Signals
signal powerup_area_placed(powerup)

#### POWER-UPS #### 

var stylebox = StyleBoxFlat.new()

func _ready():

	update_freshmen_escaped(Globals.freshmen_escaped)
	stylebox.set_corner_radius_all(20)
	countdown_timer.start()

### COUNTDOWN ###

func _process(_delta):
	var time_left = countdown_timer.time_left
	var minutes = floor(time_left/60)
	var seconds = int(time_left) % 60
	
	$CountDown/CountDownLabel.text = str(minutes, " : ", str(seconds).pad_zeros(2))
	
func _on_jump_button_pressed():
	selectedPowerup = "jump"
	$Jump/JumpContainer/JumpButton.add_theme_stylebox_override("focus", stylebox)
	
func _on_flip_button_pressed():
	selectedPowerup = "flip"
	$Flip/FlipContainer/FlipButton.add_theme_stylebox_override("focus", stylebox)
	
func _on_weight_button_pressed():
	selectedPowerup = "weight"
	$Weight/WeightContainer/WeightButton.add_theme_stylebox_override("focus", stylebox)


func update_powerup_amounts(amounts : Dictionary):
	jump_label.text = str(amounts["jump"])
	flip_label.text = str(amounts["flip"])
	weight_label.text = str(amounts["weight"])

	if amounts["jump"] <= 0:
		$Jump/JumpContainer/JumpButton.disabled = true
	if amounts["flip"] <= 0:
		$Flip/FlipContainer/FlipButton.disabled = true
	if amounts["weight"] <= 0:
		$Weight/WeightContainer/WeightButton.disabled = true

func change_cursor(powerup_is_area):
	if not powerup_is_area:
		Input.set_custom_mouse_cursor(target_path, Input.CURSOR_ARROW, Vector2(16,16))
	else:
		Input.set_custom_mouse_cursor(area_cursor, Input.CURSOR_ARROW, Vector2(20,17))

	
### PLAYERS ###

func update_freshmen_escaped(value):
	$PlayersEscaped/Label.text = str(value) + "/" + str(Globals.num_freshmen)

### AUXILIAR FUNCTIONS

func is_button_active(powerup):
	
	if powerup == "jump":
		return !$Weight/WeightContainer/WeightButton.disabled and Globals.jump_amount > 0
	elif powerup == "flip":
		return !$Flip/FlipContainer/FlipButton.disabled and Globals.flip_amount > 0
	else:
		return !$Weight/WeightContainer/WeightButton.disabled and Globals.weight_amount > 0
	
