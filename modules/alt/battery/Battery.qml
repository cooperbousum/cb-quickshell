import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Item {
  id: root
  property UPowerDevice battery: UPower.displayDevice
  property color textColor: battery.percentage > 0.2 ? "#ffffff" : "#f28779"

  Text {
    id: batteryText
    text: Math.round(root.battery.percentage * 100)
    color: root.textColor
    font.pointSize: 11
    font.family: "SF Mono"
  }
}


