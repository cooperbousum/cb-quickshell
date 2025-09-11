
pragma ComponentBehavior: Bound

import "battery"
import QtQuick 2.15
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.15
import QtQuick.Shapes

PanelWindow {
  id: root

  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  color: "transparent"
  anchors {
    left: true
    top: true
    bottom: true
  }

  implicitWidth: 0

  mask: Region {
    item: region
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  property var defaultAudioSink: Pipewire.defaultAudioSink
  property bool inside

  Column {
    anchors.fill: parent

    Rectangle {
      id: region
      anchors.verticalCenter: parent.verticalCenter
      color: "black"
      width: 60
      height: 225
      topRightRadius: 27
      bottomRightRadius: 27

      MouseArea {
        implicitHeight: 225
        implicitWidth: 60
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: event => {
          const x = event.x;
          const y = event.y;
          if (y > 10 && y < implicitHeight - 10 && x < implicitWidth - 10) {
            console.log(y)
            console.log(x)
            root.implicitWidth = 60
          } else {
            hidetimer.restart()
          }
        }
      } 

      Rectangle {
        id: bottom
        anchors.top: parent.bottom
        width: parent.bottomRightRadius
        anchors.left: parent.left
        height: parent.bottomRightRadius
        visible: false
        color: "black"
      }

      Rectangle {
        id: maskBottom
        anchors.top: parent.bottom
        width: parent.bottomRightRadius * 2
        height: parent.bottomRightRadius * 2
        topLeftRadius: width / 2
        color: "white"
        visible: false
      }

      OpacityMask {
        source: bottom
        anchors.fill: maskBottom
        maskSource: maskBottom
        invert: true
      }

      Rectangle {
        id: top
        anchors.bottom: parent.top
        anchors.left: parent.left
        width: parent.topRightRadius
        height: parent.topRightRadius
        color: "black"
        visible: false
      }

      Rectangle {
        id: maskTop
        anchors.bottom: parent.top
        anchors.left: parent.left
        width: parent.topRightRadius * 2
        bottomLeftRadius: width / 2
        color: "black"
        height: width
        visible: false
      }

      OpacityMask {
        source: top
        anchors.fill: maskTop
        maskSource: maskTop
        invert: true
      } 

      Timer {
        id: hidetimer
        interval: 1000
        onTriggered: {
          root.implicitWidth = 0
        }
      }

       Slider {
        id: volume
        anchors.centerIn: parent
        orientation: Qt.Vertical
        rotation: 0
        value: root.defaultAudioSink.audio.volume

        onMoved: {
          root.defaultAudioSink.audio.volume = volume.value
        }

        Connections {
          target: Pipewire.defaultAudioSink?.audio

          function onVolumeChanged() {
            volume.value = root.defaultAudioSink.audio.volume;
            root.implicitWidth = 60;
            hidetimer.restart();
          }
        } 

        background: Rectangle {
          implicitWidth: 32
          implicitHeight: 200
          width: volume.availableWidth
          height: implicitHeight
          radius: width / 2
          border.width: 2
          border.color: "black"
          color: "#0390FC"

          Rectangle {
            height: volume.visualPosition * (volume.implicitHeight - handle.implicitHeight) + handle.implicitHeight
            width: parent.width - 4
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#697d8c"
            radius: (width - 1) / 2
          }
        }

        handle: Rectangle {
          id: handle
          y: volume.visualPosition * (volume.implicitHeight - implicitHeight)
          x: 0
          implicitWidth: parent.width - 2
          implicitHeight: parent.width
          anchors.horizontalCenter: parent.horizontalCenter
          radius: width / 2
          color: volume.pressed ? "light gray" : "white"

          Text {
            text: Math.round(root.defaultAudioSink.audio.volume * 100)
            anchors.centerIn: parent
            font.family: "SF Mono"
          }

          MultiEffect {
            source: handle
            anchors.fill: handle
            shadowEnabled: true
            shadowOpacity: 0.4
            shadowVerticalOffset: 5
            autoPaddingEnabled: true
          }
        }

        Behavior on value {
          NumberAnimation {
            duration: Appearance.anim.durations.small
          }
        }
      }
    }
  }
}

