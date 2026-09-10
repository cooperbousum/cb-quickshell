import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import QtQuick.Layouts
import qs

PanelWindow {
  id: root
  property real targetY: (Hyprland.focusedWorkspace.id - 1) * -20
  property real animatedY: targetY
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Bottom

  
  color: "transparent"
  anchors {
    left: true
    right: true
    top: true
    bottom: true
  }

  mask: Region {
      item: region
      intersection: Intersection.Xor
  }

  Rectangle {
    id: region
    anchors.fill: parent
    color: "transparent"
  }

  Image {
    id: wallpaper
    source: Globals.wallpaper
    width: Hyprland.focusedMonitor.width * 1
    fillMode: Image.PreserveAspectFit
    y: animatedY 
  }

  onTargetYChanged: {
    animatedY = targetY
  }

  Behavior on animatedY {
    NumberAnimation {
      duration: Globals.animDuration * 3
      easing.type: Globals.animType
      easing.amplitude: Globals.animAmp
      easing.period: Globals.animPeriod
      easing.overshoot: Globals.animOvershoot
    }
  }
}
