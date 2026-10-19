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

