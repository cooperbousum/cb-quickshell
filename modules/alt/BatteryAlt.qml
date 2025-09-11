import "battery"
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Item {
  id: root
  property UPowerDevice battery: UPower.displayDevice

  Text {
    id: battery 
    text: Math.round(root.battery.percentage * 100) 
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: batteryIcon.right
    anchors.leftMargin: implicitWidth / 2

    color: {
      if (text > 20) {
        return "#ffffff"
      } else {
        return "#f28779"
      }
    }

    font.pointSize: 11
    font.family: "SF Mono"
  } 

}

