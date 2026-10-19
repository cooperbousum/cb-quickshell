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
    id: volbright
    anchors.fill: parent

    property alias volbrightHover: volbrightHover
    property alias volbrightPopout: volbrightPopout
    property bool isHovered: false

    onIsHoveredChanged: {
      if (isHovered) {
        topFillet.visible = true
        botFillet.visible = true
        volbrightPopout.visible = true
        topFilletScaleOpenAnim.start()
        topFilletXOpenAnim.start()
        botFilletScaleOpenAnim.start()
        botFilletXOpenAnim.start()
      } else {
        topFilletScaleCloseAnim.start()
        topFilletXCloseAnim.start()
        botFilletScaleCloseAnim.start()
        botFilletXCloseAnim.start()
      }
    }
    
    Timer {
      id: hideTimer
      interval: 2000
      repeat: false
      onTriggered: {
        isHovered = false
      }
    }

    Popout {
      id: volbrightPopout
      visible: false
      anchors.verticalCenter: parent.verticalCenter
      height: 400
      width: 200
      topLeftRadius: 30
      bottomLeftRadius: 30
      color: Globals.primaryColor
      x: volbright.isHovered ? parent.width - width * 0.9 - Globals.marginSize : parent.width + 50

      RowLayout {
        anchors.fill: parent

        Item {
          width: 5
        }

        Module {
          id: brightness
          text: ""
          Layout.preferredHeight: 40
          moduleWidth: 340
          Layout.fillWidth: false
          bgColor: brightnessHover.hovered ? "#d4b039" : Globals.primaryColor

          property real brightnessPercent
          progress: Globals.brightness

          Process {
            id: brightnessMonitor
            command: ["udevadm", "monitor", "--udev", "--subsystem-match=backlight"]
            running: true
            stdout: StdioCollector {
              waitForEnd: false
              onTextChanged: {
                brightnessGet.running = true
                volbright.isHovered = true
                hideTimer.restart()
                hideTimer.running = true
              }
            }
          }

          Process {
            id: brightnessGet
            command: ["brightnessctl","-m"]
            stdout: StdioCollector {
              waitForEnd: true
              onStreamFinished: {
                Globals.brightness = parseFloat(this.text.split(',')[3]); 
              }
            }
          }
 

          HoverHandler {
            id: brightnessHover

            onHoveredChanged: {
              if (hovered) {
                console.log("hovered")
              }
            }
          }

          rotation: 90
        }
      }
    }

    Fillet {
      id: topFillet
      visible: false
      anchors.top: volbrightPopout.top
      anchors.topMargin: -30
      x: parent.width
      transform: Scale {
        id: topFilletScale
        xScale: 1
        origin.x: 0
        origin.y: 30
      }

      rotation: 0
    }

    Fillet {
      id: botFillet
      visible: false
      anchors.bottom: volbrightPopout.bottom
      anchors.bottomMargin: 30
      x: parent.width
      transform: Scale {
        id: botFilletScale
        xScale: 1
        yScale: -1
        origin.x:0
        origin.y:30
      }

      rotation: 0
    }

    Rectangle {
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      height: 450
      width: Globals.marginSize
      color: Globals.primaryColor
    }


    Rectangle {
      id: mouseHandler
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      height: 400
      width: volbrightHover.isHovered ? Globals.marginSize + volbrightPopout.width : Globals.marginSize
      color: "transparent"

      NumberAnimation {
        id: topFilletScaleOpenAnim
        target: topFilletScale
        property: "xScale"
        to: 1
        from: 1.5
        duration: 300
        easing.type: Easing.OutQuad
        easing.amplitude: 1.5
        easing.period: Globals.animPeriod
        easing.overshoot: 1.5
      }

      NumberAnimation {
        id: topFilletScaleCloseAnim
        target: topFilletScale
        property: "xScale"
        to: 0
        from: 1
        duration: 500
        easing.type: Easing.InOutQuad
        easing.amplitude: 1.5
        easing.overshoot: 1.5
      }

      NumberAnimation {
        id: topFilletXOpenAnim
        target: topFillet
        property: "x"
        to: volbright.width - Globals.marginSize - 30
        from: volbright.width
        duration: 350
        easing.type: Easing.OutQuad
      }

      NumberAnimation {
        id: topFilletXCloseAnim
        target: topFillet
        property: "x"
        to: volbright.width
        from: volbright.width - Globals.marginSize - 30
        duration: 200
        easing.type: Easing.InOutQuad
      }

      NumberAnimation {
        id: botFilletScaleOpenAnim
        target: botFilletScale
        property: "xScale"
        to: 1
        from: 1.5
        duration: 300
        easing.type: Easing.OutQuad
        easing.amplitude: 1.5
        easing.period: Globals.animPeriod
        easing.overshoot: 1.5
      }

      NumberAnimation {
        id: botFilletScaleCloseAnim
        target: botFilletScale
        property: "xScale"
        to: 0
        from: 1
        duration: 500
        easing.type: Easing.InOutQuad
        easing.amplitude: 1.5
        easing.overshoot: 1.5
      }

      NumberAnimation {
        id: botFilletXOpenAnim
        target: botFillet
        property: "x"
        to: volbright.width - Globals.marginSize - 30
        from: volbright.width
        duration: 350
        easing.type: Easing.OutQuad
      }

      NumberAnimation {
        id: botFilletXCloseAnim
        target: botFillet
        property: "x"
        to: volbright.width
        from: volbright.width - Globals.marginSize - 30
        duration: 200
        easing.type: Easing.InOutQuad
      }
        
      HoverHandler {
        id: volbrightHover

        onHoveredChanged: {
          if (hovered) {
            volbright.isHovered = true
          } else {
            volbright.isHovered = false
          }
        }
      }
    }
  }

