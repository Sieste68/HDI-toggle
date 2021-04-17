//%attributes = {}
/* 
z_getPictureFromResources
     Parameters:
      $1: path (text)
      $0: picture
     ----------------------------------------------------
    Description:
     upload picture from 'resources/$1' path
     ----------------------------------------------------
      Creation: QualiSoft - Patrick EMANUEL, 17/04/21, 09:09:00
*/

var $1; $path : Text
var $0; $img : Picture

ASSERT:C1129(Count parameters:C259=1; "1 parameter expected")
ASSERT:C1129(Type:C295($1)=Is text:K8:3; "$1 must be a path like images/name.png")

$path:=Folder:C1567(fk resources folder:K87:11).file($1).platformPath
READ PICTURE FILE:C678($path; $Img)
$0:=$img