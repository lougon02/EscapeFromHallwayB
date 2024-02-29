extends CanvasLayer

@onready var jump_label : Label = $Jump/JumpContainer/Label
@onready var flip_label : Label = $Flip/FlipContainer/Label
@onready var weight_label : Label = $Weight/WeightContainer/Label

var stylebox = StyleBoxFlat.new()

func _ready():
	update_jump_button()
	update_flip_button()
	update_weight_button()
	stylebox.set_corner_radius_all(20)
	
func _on_jump_button_pressed():
	Globals.is_jump = true
	Globals.is_flip = false
	Globals.is_weight = false

	$Jump/JumpContainer/JumpButton.add_theme_stylebox_override("focus", stylebox)
	change_cursor()
	
func _on_flip_button_pressed():
	Globals.is_flip = true
	Globals.is_jump = false
	Globals.is_weight = false

	$Flip/FlipContainer/FlipButton.add_theme_stylebox_override("focus", stylebox)
	change_cursor()
	
func _on_weight_button_pressed():
	Globals.is_weight = true
	Globals.is_flip = false
	Globals.is_jump = false

	$Weight/WeightContainer/WeightButton.add_theme_stylebox_override("focus", stylebox)
	change_cursor()
	
func update_jump_button():
	jump_label.text = str(Globals.jump_amount)
	if Globals.jump_amount <= 0:
		$Jump/JumpContainer/Button.disabled = true
		Globals.is_jump = false
		reset_cursor()
	
func update_flip_button():
	flip_label.text = str(Globals.flip_amount)
	if Globals.flip_amount <= 0:
		$Flip/FlipContainer/FlipButton.disabled = true
		Globals.is_flip = false
		reset_cursor()
	
func update_weight_button():
	weight_label.text = str(Globals.weight_amount)
	if Globals.weight_amount <= 0:
		$Weight/WeightContainer/WeightButton.disabled = true
		Globals.is_weight = false
		reset_cursor()
	
func change_cursor():
	var target_path = preload("res://assets/objects/target.png")
	Input.set_custom_mouse_cursor(target_path)
	
func reset_cursor():
	Input.set_custom_mouse_cursor(null)
