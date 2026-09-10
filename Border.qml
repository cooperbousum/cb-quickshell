import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import QtQuick.Layouts
import qs
import Quickshell.Services.UPower

PanelWindow {
  id: root
  property int marginSize
  property int holeMargin: Globals.marginSize
  property int bottomMarginSize
  property int cornerRadius
  property int barHeight: Globals.barHeight
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Top

  
  color: "transparent"
  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  mask: Region {
      item: region
      intersection: Intersection.Xor
  }

  Rectangle {
    id: region
    anchors.fill: parent
    anchors.bottomMargin: root.barHeight + bottomMarginSize
    anchors.rightMargin: Globals.marginSize
    color: "transparent"
  }
  
  Item {
    anchors.fill: parent

    Rectangle {
      id: shadow
      anchors.fill: parent
      anchors.leftMargin: root.holeMargin - 15
      anchors.rightMargin: root.holeMargin - 15
      anchors.topMargin: root.holeMargin - 15
      anchors.bottomMargin: bottomMarginSize + root.barHeight - 14
      radius: root.cornerRadius * 1.5
      color: "transparent"
      border.color: Globals.primaryColor
      border.width: 15
      layer.enabled: true
      layer.effect: MultiEffect {
        shadowEnabled: true
        shadowScale: 1
        shadowColor: Globals.shadowColor
        autoPaddingEnabled: true
        shadowBlur: 1
        shadowHorizontalOffset: 0
      }
    }

    Item {
      anchors.fill: parent

      Rectangle {
        id: border
        anchors.fill: parent
        anchors.bottomMargin: root.barHeight
        color: Globals.primaryColor
        visible: false
      }

      Item {
        id: maskSource
        anchors.fill: parent
        visible: false
        layer.enabled: true

        Rectangle {
          id: mask
          color: "blue"
          anchors.fill: parent
          anchors.leftMargin: root.holeMargin
          anchors.rightMargin: root.holeMargin
          anchors.topMargin: root.holeMargin
          anchors.bottomMargin: (bottomMarginSize) + root.barHeight
          radius: root.cornerRadius
        }
      } 

      OpacityMask {
        anchors.fill: parent
        invert: true
        source: border
        maskSource: maskSource
        visible: true
        layer.effect: MultiEffect {
          shadowEnabled: true
        }
      }
    }
  }
  
  Volbright {}

  Item {
    anchors.fill: parent
    Rectangle {
      id: bar
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.bottomMargin: bottomMarginSize
      color: "transparent"
      height: root.barHeight
      width: parent.width
      clip: true

      HoverHandler {
        id: barHover

        onHoveredChanged: {
          if (hovered) {
            Globals.mouseOverBar = true
          } else {
            Globals.mouseOverBar = false
            root.barHeight = 40
          }
        }
      } 

      RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: root.holeMargin + 30
        anchors.rightMargin: root.holeMargin + 30
        spacing: 30
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        Layout.preferredHeight: root.barHeight * 0.9 

        Module {
          id: power
          property string inText
          Layout.preferredHeight: root.barHeight * 0.8
          Layout.alignment: Qt.AlignVCenter
          Layout.fillWidth: false
          progress: (parseInt(inText) * 100) / 72

          Process {
            id: powerProc
            command: ["sh", "-c", "awk 'NR==1{a=$1} NR==2{printf \"%.0f\", a*$1/1e12}' /sys/class/power_supply/BAT0/current_now /sys/class/power_supply/BAT0/voltage_now"]
            running: true

            stdout: StdioCollector {
              onStreamFinished: power.inText = this.text + " w"
            }
          }

          Timer {
            interval: 5000
            running: true
            repeat: true
            onTriggered: powerProc.running = true
          }

          text: inText
        }

        Item { Layout.fillWidth: true }

        Module {
          id: clock
          text: Qt.formatDateTime(systemClock.date, "h:mm ap") 
          Layout.preferredHeight: root.barHeight * 0.8
          Layout.fillWidth: false
          bgColor: clockHover.hovered ? Globals.tertiaryColor : Globals.secondaryColor

          SystemClock {
            id: systemClock
            precision: SystemClock.Minutes
          }

          HoverHandler {
            id: clockHover
          }
        }

        Item { Layout.fillWidth: true }

        Module {
          id: battery
          text: Math.round(UPower.displayDevice.percentage * 100)
          progress:  Math.round(UPower.displayDevice.percentage * 100)
          progressColor: "#64AB67"
          Layout.preferredHeight: root.barHeight * 0.8
          Layout.alignment: Qt.AlignVCenter
          Layout.fillWidth: false
        } 
      }
    }
  }
}
