
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
  property int tm: 14
  property real textOpacity: 0
  anchors {
    top: true
  }
  implicitWidth: 300
  implicitHeight: 0
  Behavior on implicitHeight {
    NumberAnimation {
      duration: 200
      easing.type: Easing.OutQuad
    }
  }
  Behavior on tm {
    NumberAnimation {
      duration: 50
      easing.type: Easing.OutQuad
    }
  }
  color: "transparent"

  Rectangle {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: tm
    color: "black"

    Behavior on height {
      NumberAnimation {
        duration: 100
        easing.type: Easing.OutQuad
      }
    }
  }

  Rectangle { 

    opacity: 0
    Component.onCompleted: opacity = 1

    id: rect
    radius: 20
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.leftMargin: radius * 2
    anchors.rightMargin: radius * 2
    anchors.topMargin: tm
    anchors.bottomMargin: 0
    color: "black"

    anchors {
      //top: parent.top
      right: parent.right
      left: parent.left
    }

    Rectangle {
      id: maskTop
      height: parent.radius * textOpacity
      color: "black"
      anchors {
        left: leftCorner.right
        right: rightCorner.left
      }
    }

    Rectangle {
      id: leftCorner
      width: parent.radius
      height: parent.radius * textOpacity
      color: "black"
      visible: true
      
      anchors {
        top: parent.bottom
        right: parent.left
      }
      anchors.bottomMargin: 0
    }

    Rectangle {
      id: maskLeftRect
      width: parent.radius * 2
      height: parent.radius * 2 * textOpacity
      radius: parent.radius 
      color: "white"
      visible: false

      anchors {
        top: parent.top
        right: parent.left
      }

      Rectangle {
        id: maskLeftBottom
        width: parent.radius
        height: parent.radius * textOpacity

        anchors {
          bottom: parent.bottom
          left: parent.left
          right: parent.right
        }
      } 

      Rectangle {
        id: maskleft
        width: parent.radius
        height: parent.radius * textOpacity

        anchors {
          bottom: parent.bottom
          left: parent.left
          top: parent.top
        }
      } 
    }

    OpacityMask {
      source: leftCorner
      anchors.fill: maskLeftRect
      maskSource: maskLeftRect
      invert: true
      visible: true
    }

    Rectangle {
      id: rightCorner
      width: parent.radius
      height: parent.radius * textOpacity
      color: "black"
      visible: false
      
      anchors {
        top: parent.top
        left: parent.right
      } 
    }

    Rectangle {
      id: maskRightRect
      width: parent.radius * 2
      height: parent.radius * 2 * textOpacity
      radius: parent.radius 
      color: "white"
      visible: false

      anchors {
        top: parent.top
        left: parent.right
      }

      Rectangle {
        id: maskRightBottom
        width: parent.radius
        height: parent.radius * textOpacity

        anchors {
          bottom: parent.bottom
          left: parent.left
          right: parent.right
        }
      } 

      Rectangle {
        id: maskRight
        width: parent.radius
        height: parent.radius * textOpacity

        anchors {
          bottom: parent.bottom
          right: parent.right
          top: parent.top
        }
      } 
    } 

    OpacityMask {
      source: rightCorner
      anchors.fill: maskRightRect
      maskSource: maskRightRect
      invert: true
    }
    
    Item {
      id: root
      anchors.fill: parent  

      Item {
        id: child
        anchors.fill: parent 
        opacity: barWin.textOpacity

        Behavior on opacity {
          NumberAnimation {
            duration: 100
            easing.type: Easing.OutQuad
          }
        }

        ClockAlt {
          id: clock
          anchors.left: parent.left
          anchors.leftMargin: 15
          anchors.verticalCenter: child.verticalCenter
        }

        Icon {
          id: battIcon
          anchors.right: percent.left
          anchors.rightMargin: 30
          height: 44
          color: percent.textColor
        }

        Power {
          id: power
          anchors.right: battIcon.left
          anchors.rightMargin: 25 + implicitWidth * 4
          anchors.verticalCenter: parent.verticalCenter
          height: 14
        }

        Battery {
          id: percent
          anchors.right: parent.right
          anchors.leftMargin: 15
          anchors.rightMargin: 35
          anchors.verticalCenter: parent.verticalCenter
          height: 16.5
        }
      }
    }
  }
}


