import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Effects
import QtQuick.Layouts
import qs
import Quickshell.Services.UPower

Rectangle {
  id: root
  property int arcSize: 30

  Behavior on x {
    NumberAnimation {
      duration: 1000
      easing.type: Globals.animType
      easing.amplitude: 0.5
      easing.period: 1.2
      easing.overshoot: 0.1
    }
  }

  layer.enabled: true
  layer.samples: 5
  layer.effect: MultiEffect {
    shadowEnabled: true
    shadowScale: 1
    shadowColor: Globals.shadowColor
    autoPaddingEnabled: true
    shadowBlur: 1
    shadowHorizontalOffset: 0
  }
}
