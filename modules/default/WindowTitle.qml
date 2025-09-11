import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io

Item {

  //implicitWidth: 25
  width: 10
  height: 10
  visible: true

  Text {
    anchors.centerIn: parent
    id: window
   // property Toplevel window: Hyprland.activeToplevel
   font.family: "SF Mono" // Assuming Font Awesome is available
    font.pointSize: 9
    color: "white" 

    text: Hyprland.activeToplevel?.title ?? "Desktop"
    elide: Text.ElideRight
    clip: true
    //text: "hello"
    transform: Rotation {
      origin.x: window.width / 2
      origin.y: window.height / 2
      angle: 270
    } 
  }
}
