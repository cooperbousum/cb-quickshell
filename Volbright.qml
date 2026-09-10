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

    Popout {
      id: volbrightPopout
      visible: false
      anchors.verticalCenter: parent.verticalCenter
      height: 400
      width: 200
      topLeftRadius: 30
      bottomLeftRadius: 30
      color: Globals.primaryColor
      x: volbrightHover.hovered ? parent.width - width * 0.9 - Globals.marginSize : parent.width + 50
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
      }
    }
  }

