//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($ps; $win)
C_OBJECT:C1216($options)
C_TEXT:C284($cr)

Case of 
	: (Count parameters:C259=0)
		$ps:=New process:C317(Current method name:C684; 0; Current method name:C684; 0)
		
	Else 
		
		If (Shift down:C543)  //  for debug purpose only
			$win:=Open form window:C675("HDI"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		Else 
			$win:=Open form window:C675("HDI"; Pop up form window:K39:11; Horizontally centered:K39:1; Vertically centered:K39:4)
		End if 
		
		__defineToggleValues
		
		$options:=New object:C1471
		
		$options.title:=""
		$options.title:=$options.title+"a Toggle object with a single Class\r"
		$options.blog:="https://github.com/Sieste68/HDI-toggle"
		$options.info:="4D Toggle Class"  //ex : "4D View Pro feature"
		
		$options.minimumVersion:="1850"  // 1840 means 18R4   1804 means 18.4 (do not use !)
		
		//$options.license:=4D View license  // IF ANY NEEDED
		//$options.license:=4D Write license  // IF ANY NEEDED
		
		// THE BACKGROUND PICTURE IS IN THE RESOURCES : Resources/Images/HDIabout.png
		// the picture size is 724 * 364
		// these 3 commented lines should be removed when done !
		
		DIALOG:C40("HDI"; $options)
		CLOSE WINDOW:C154
		
		If ($options.quit=True:C214)
			QUIT 4D:C291
		Else 
			$win:=Open form window:C675("HDI2"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("HDI2")
			CLOSE WINDOW:C154
		End if 
		
End case 
