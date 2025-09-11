
pragma ComponentBehavior: Bound

import "battery"
import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io
import Qt5Compat.GraphicalEffects

PanelWindow {
  id: barWin 
  implicitWidth: 30
  implicitHeight: 25

  anchors {
    top: true
    bottom: true
    right: true
  }

  color: "transparent"

  Item {
    id: container
    anchors.fill: parent 
    
    Rectangle {
      id: rect
      anchors.fill: parent
      color: "black"
    }

    Clock {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 20
    }

    /*WindowTitle {
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter
    }*/

    Power {
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: icon.top
      anchors.bottomMargin: 15
      anchors.leftMargin: 7
    }

    Icon {
      id: icon
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: battery.top
      color: battery.textColor
      anchors.bottomMargin: 35
      anchors.rightMargin: 0
      anchors.leftMargin: 1

      transform: Rotation {
        angle: 270
        origin.x: implicitWidth / 2
        origin.y: implicitHeight / 2
      }
    }

    Battery {
      id: battery
      textSize: 10
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 40
      anchors.leftMargin: 7
    }
  } 
}


