Class constructor($button : Text; $container : Text; $left : Picture; $right : Picture; $togglePict : Picture)
	
	If (Count parameters:C259>=2)
		This:C1470.container:=$container
		This:C1470.button:=$button
		This:C1470.dragging:=False:C215
		This:C1470.tracking:=False:C215
		This:C1470.position:=0
		
		If (Count parameters:C259>2)
			This:C1470._setImages($left; $right; $togglePict)
			
		Else 
/*
$left: image when button is on the left
$right: container background image when button is on the right
$togglePict: container background
*/
			
			$left:=z_getPictureFromResources("images/bad.png")
			$right:=z_getPictureFromResources("images/smile.png")
			$togglePict:=z_getPictureFromResources("images/grayRoundBackground.png")
			
			This:C1470._setImages($left; $right; $togglePict)
		End if 
	Else 
		ALERT:C41("Cannot instantiate this object. Need 2 parameters: button & container names.")
	End if 
	
	
Function handle_mouse_up
	var $moved : Boolean
	
	This:C1470.set_val("tracking"; True:C214)
	This:C1470.slide()
	
	If (This:C1470.get_val("dragging")#True:C214)
		This:C1470.set_image(This:C1470.button; This:C1470.get_pic(This:C1470.get_val("position")))
	End if 
	
	
Function click->$pos : Integer
	var $container; $button : Text
	
	$container:=This:C1470.container
	$button:=This:C1470.button
	
	If (This:C1470.get_val("position")=0)
		$pos:=1
	Else 
		$pos:=0
	End if 
	This:C1470.set_val("position"; $pos)
	This:C1470.set_pos($pos)
	
	
Function slide
	var $container; $button : Text
	var $width; $length : Integer
	var $cl; $ct; $cr; $cb : Integer
	var $sl; $st; $sr; $sb : Integer
	var $mX; $mY; $mB : Integer
	var $left; $right : Integer
	
	$container:=This:C1470.container
	$button:=This:C1470.button
	
	OBJECT GET COORDINATES:C663(*; $container; $cl; $ct; $cr; $cb)
	OBJECT GET COORDINATES:C663(*; $button; $sl; $st; $sr; $sb)
	$width:=$sr-$sl
	$length:=$sb-$st
	
	If (($sl-$cl)<($cr-$sr))
		This:C1470.set_pos(0)
	Else 
		This:C1470.set_pos(1)
	End if 
	This:C1470.handle_move()
	
	
Function handle_move
	var $tracking : Boolean
	
	$tracking:=This:C1470.get_val("tracking")
	If ($tracking)  // we are in tracking mode
		
		If (Not:C34(Is waiting mouse up:C1422))
			$tracking:=False:C215  // stop the tracking mode
			This:C1470.set_val("tracking"; $tracking)
			
		Else   // the object is still waiting for a mouse up
			This:C1470.set_image(This:C1470.button; This:C1470.get_pic(This:C1470.move()))
		End if 
	End if 
	
	
Function move->$pos : Integer
	var $container; $button : Text
	var $width; $length : Integer
	var $cl; $ct; $cr; $cb : Integer
	var $sl; $st; $sr; $sb : Integer
	var $mX; $mY; $mB : Integer
	var $left; $right : Integer
	
	$container:=This:C1470.container
	$button:=This:C1470.button
	
	OBJECT GET COORDINATES:C663(*; $container; $cl; $ct; $cr; $cb)
	OBJECT GET COORDINATES:C663(*; $button; $sl; $st; $sr; $sb)
	$width:=$sr-$sl
	$length:=$sb-$st
	GET MOUSE:C468($mX; $mY; $mB)
	// check bounds to keep switch in container
	
	Case of 
		: ($sl<=$cl) & (($mX-($width/2))<$cl)
			OBJECT SET COORDINATES:C1248(*; $button; $cl; $st; $cl+$width; $sb)
			
		: ($sr>=$cr) & (($mX+($width/2))>$cr)
			OBJECT SET COORDINATES:C1248(*; $button; $cr-$width; $st; $cr; $sb)
			
		Else 
			This:C1470.set_val("dragging"; True:C214)
			$left:=$mX-($width/2)
			$right:=$mX+($width/2)
			OBJECT SET COORDINATES:C1248(*; $button; $left; $st; $right; $sb)
	End case 
	This:C1470.set_val("position"; This:C1470.get_pos())
	
	
Function get_pos->$pos : Integer
	var $container; $button : Text
	var $width; $length : Integer
	var $cl; $ct; $cr; $cb : Integer
	var $sl; $st; $sr; $sb : Integer
	var $mX; $mY; $mB : Integer
	var $containerMid; $buttonMid : Integer
	
	$container:=This:C1470.container
	$button:=This:C1470.button
	
	OBJECT GET COORDINATES:C663(*; $container; $cl; $ct; $cr; $cb)
	OBJECT GET COORDINATES:C663(*; $button; $sl; $st; $sr; $sb)
	
	$containerMid:=$cl+(($cr-$cl)/2)
	$buttonMid:=$sl+(($sr-$sl)/2)
	
	If ($buttonMid<$containerMid)
		$pos:=0
	Else 
		$pos:=1
	End if 
	
	
Function handler
	var $event : Integer
	
	$event:=Form event code:C388
	Case of 
		: ($event=On Mouse Move:K2:35)
			This:C1470.set_val("tracking"; True:C214)
			This:C1470.handle_move()
			
		: ($event=On Mouse Up:K2:58)  // On Mouse Up: the mouse button was released
			This:C1470.handle_mouse_up()
			
		: ($event=On Clicked:K2:4)
			//This.handle_click()
	End case 
	
	
Function switch
	This:C1470.set_image(This:C1470.button; This:C1470.get_pic(This:C1470.click())
	
	
Function handle_click
	var $tracking; $moved : Boolean
	
	$tracking:=False:C215
	$moved:=False:C215
	This:C1470.set_val("dragging"; $moved)
	
	$tracking:=Is waiting mouse up:C1422
	If ($tracking)  // the mouse button is still not released
		This:C1470.set_val("tracking"; $tracking)
	End if 
	This:C1470.switch()
	
	
Function _setImages($left : Picture; $right : Picture; $togglePict : Picture)
	This:C1470.buttonPicture:=$togglePict
	This:C1470.leftPicture:=$left
	This:C1470.rightPicture:=$right
	
	
Function get_val($prop : Text)->$val : Variant
	$val:=This:C1470[$prop]
	
	
Function set_val($prop : Text; $val : Variant)
	This:C1470[$prop]:=$val
	
	
Function set_button_position($pos : Integer)
	If ($pos=0) | ($pos=1)
		This:C1470.set_pos($pos)
		This:C1470.set_val("position"; $pos)
		This:C1470.set_image(This:C1470.button; This:C1470.get_pic($pos))
	End if 
	
	
Function set_image($widget : Text; $pic : Picture)
	var $ptr : Pointer
	
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $widget)
	$ptr->:=$pic
	
Function get_pic($pos : Integer)->$pic : Picture
	var $prop : Text
	
	Case of 
		: ($pos=0)
			$prop:="leftPicture"
			
		: ($pos=1)
			$prop:="rightPicture"
	End case 
	$pic:=This:C1470[$prop]
	
	
Function set_pos($pos : Integer)
	var $container; $button : Text
	var $width; $length : Integer
	var $cl; $ct; $cr; $cb : Integer
	var $sl; $st; $sr; $sb : Integer
	
	$container:=This:C1470.container
	$button:=This:C1470.button
	
	OBJECT GET COORDINATES:C663(*; $container; $cl; $ct; $cr; $cb)
	OBJECT GET COORDINATES:C663(*; $button; $sl; $st; $sr; $sb)
	$width:=$sr-$sl
	$length:=$sb-$st
	
	If ($pos=0)  // set button to left side of container
		OBJECT SET COORDINATES:C1248(*; $button; $cl; $st; $cl+$width; $sb)
	Else   // set button to right side of container
		OBJECT SET COORDINATES:C1248(*; $button; $cr-$width; $st; $cr; $sb)
	End if 