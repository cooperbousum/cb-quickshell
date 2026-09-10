import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import QtQuick.Layouts
import qs

Item {
  id: root
  property string text: "default"
  property real progress: 0
  property color progressColor: Globals.tertiaryColor
  property int moduleWidth: 100
  property color bgColor: Globals.secondaryColor

  default property alias data: root.data

  property int padding: 30
  implicitWidth: label.contentWidth + padding

  Behavior on progress {
    NumberAnimation {
      duration: Globals.animDuration * 4
      easing.type: Globals.animType
      easing.amplitude: Globals.animAmp
      easing.period: Globals.animPeriod
      easing.overshoot: Globals.animOvershoot
    }
  }

  Behavior on bgColor {
    ColorAnimation {
      duration: 300
      easing.type: Easing.InOutQuad
    }
  }


  Rectangle {
    id: module
    height: parent.height / 1
    anchors.verticalCenter: parent.verticalCenter
    width: label.contentWidth + 30
    color: "transparent"
    border.color: "black"
    border.width: 2
    radius: parent.height / 2
    anchors.horizontalCenter: parent.horizontalCenter
    z: 0
    layer.enabled: true
    layer.effect: MultiEffect {
      shadowEnabled: true
      shadowHorizontalOffset: 2
      shadowVerticalOffset: 2
      shadowBlur: 0.5
      shadowColor: Globals.highlightColor
      autoPaddingEnabled: false
      paddingRect: Qt.rect(20, 20, 0, 0)
    } 
  } 

  Text {
    id: label
    anchors.centerIn: parent
    text: root.text
    color: Globals.textColor
    font.pointSize: parent.height * 0.35
    font.family: "SF Pro"
    font.weight: 600
    anchors.fill: parent
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter    
  }

  Rectangle {
    id: bgColor
    anchors.fill: module
    radius: parent.height / 2
    color: root.bgColor
    z: -2
  }

  Rectangle {
    id: blocker
    anchors.fill: module
    anchors.topMargin: -10.5
    anchors.bottomMargin: -10.5
    anchors.rightMargin: -10
    anchors.leftMargin: -10
    radius: height / 2
    color: "transparent"
    border.color: Globals.primaryColor
    border.width: 12.5
  }

  Item {
    id: progressWrapper
    anchors.fill: module
    visible: root.progress > 0
    z: -1
    layer.enabled: true
    layer.effect: MultiEffect {
      shadowEnabled: false
      shadowColor: "black"
      shadowHorizontalOffset: 2
      shadowVerticalOffset: 2
      shadowBlur: 0.5
      autoPaddingEnabled: true
    }

    Rectangle {
      id: progressBar
      anchors.fill: parent
      anchors.leftMargin: module.width - (root.progress / 100) * module.width
      color: root.progressColor
      radius: (root.progress * 100) / height
    }
  } 
}
