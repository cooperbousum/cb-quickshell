
pragma ComponentBehavior: Bound

import "modules/alt"
import "modules/alt/battery"
import "modules/default"
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

ShellRoot {
  PanelWindow {
    id: win
    name: "cb-bar"

    required property string name

    WlrLayershell.namespace: `cb-${name}`
    color: "transparent"

    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    
    Item {
      id: root
      anchors.fill: parent

      property bool noWindows

      Popout {}

      Border {
        id: border

        Behavior on marginSize {
          NumberAnimation { 
            duration: 300
            easing.type: Easing.OutQuad
          }
        }

        Behavior on rightMarginSize {
          NumberAnimation {
            duration: 300
            easing.type: Easing.OutQuad
          }
        }
      }

      BarAlt {
        id: barAlt
      }

      Bar {
        id: bar
      }

      Process {
        id: windowsCheck
        command: ["/home/cooperbousum/.config/quickshell/cb/services/windows.sh"]
        running: true
        stdout: StdioCollector {
          waitForEnd: false
          onTextChanged: {
            const lastLine = text.split("\n").filter(line => line !== "").pop() 
            root.noWindows = (lastLine === "true")
          }
        }
      }

      states: [
        State {
          name: "noWindows"
          when: root.noWindows
          PropertyChanges {
            target: border
            marginSize: 15
            rightMarginSize: 15
            cornerRadius: 35
          }
          PropertyChanges {
            target: barAlt
            implicitHeight: 55
            tm: 15
            textOpacity: 1
          }
          PropertyChanges {
            target: bar
            implicitWidth: 0
          }
        },
        State {
          name: "windows"
          when: !root.noWindows
          PropertyChanges {
            target: border
            marginSize: 5
            rightMarginSize: 30
            cornerRadius: 20
          }
          PropertyChanges {
            target: barAlt
            implicitHeight: 0
            tm: 0
            textOpacity: 0
          }
          PropertyChanges {
            target: bar
            implicitWidth: 25
          }
        }
      ]

      transitions: Transition {
        PropertyAnimation {
          property: "textOpacity"
          easing.type: Easing.InOutQuad
        }
      }

      Component {
        id: defaultComp
        Item {
          Bar {}
        }
      }
    }
  }
}



