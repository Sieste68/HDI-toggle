$ref:=String:C10(Num:C11(OBJECT Get name:C1087(Object current:K67:2)))

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		var $left; $right; $toggle : Picture
		$left:=z_getPictureFromResources("images/feuRouge.png")
		$right:=z_getPictureFromResources("images/feuVert.png")
		$toggle:=z_getPictureFromResources("images/Select.png")
		Form:C1466[$ref]:=cs:C1710.QS_toggle.new("button"+$ref; "container"+$ref; $left; $right; $toggle)
		//Form[$ref]:=cs.QS_toggle.new("button"+$ref; "container"+$ref) // by default
		
		$bool:=option4
		
		Form:C1466[$ref].set_pos(Num:C11($bool))
		Form:C1466[$ref].set_image(Form:C1466[$ref].button; Form:C1466[$ref].get_pic(Num:C11($bool)))
		Form:C1466[$ref].set_image(Form:C1466[$ref].container; Form:C1466[$ref].buttonPicture)
		
	: (Form event code:C388=On Unload:K2:2)
		Use (Storage:C1525)
			If (Storage:C1525.param=Null:C1517)
				Storage:C1525.param:=New shared object:C1526
			End if 
			Use (Storage:C1525.param)
				Storage:C1525.param.option4:=Bool:C1537(Form:C1466[$ref].get_pos())
			End use 
		End use 
		
	Else 
		Form:C1466[$ref].handler()
End case 

