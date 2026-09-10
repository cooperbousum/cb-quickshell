import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

ShellRoot {

  Item {
    id: root
    property bool noWindows: true

    Wall {
      id: wall 
    }

    Border {
      id: border

      Behavior on holeMargin {
        NumberAnimation { 
          duration: Globals.animDuration
          easing.type: Globals.animType
          easing.amplitude: Globals.animAmp
          easing.period: Globals.animPeriod
          easing.overshoot: Globals.animOvershoot
        }
      }

      Behavior on barHeight {
        NumberAnimation {
          duration: Globals.animDuration
          easing.type: Easing.OutElastic
          easing.amplitude: Globals.animAmp
          easing.period: Globals.animPeriod
          easing.overshoot: Globals.animOvershoot
        }
      }

      Behavior on bottomMarginSize {
        NumberAnimation {
          duration: 200
          easing.type: Easing.InOutQuad
          easing.amplitude: 0.2
          easing.period: 1
          easing.overshoot: 0
        }
      }

      Behavior on cornerRadius {
        NumberAnimation {
          duration: Globals.animDuration
          easing.type: Globals.animType
          easing.amplitude: Globals.animAmp
          easing.period: Globals.animPeriod
          easing.overshoot: Globals.animOvershoot
        }
      }
      visible: true
    } 

    Process {
      id: windowsCheck
      command: ["/home/cooperb/.config/quickshell/windows.sh"]
      running: true
      stdout: StdioCollector {
        waitForEnd: false
        onTextChanged: {
          const lastLine = text.split("\n").filter(line => line !== "").pop() 
          Globals.noWindows = (lastLine === "true")
        }
      }
    }

    Process {
      id: windowHeight
      command: ["/home/cooperb/.config/quickshell/fullheight.sh"]
      running: true
      stdout: StdioCollector {
        waitForEnd: false
        onTextChanged: {
          const lastLine = text.split("\n").filter(line => line !== "").pop() 
          Globals.fullHeight = (lastLine === "true")
        }
      }
    }


    states: [
      State {
        name: "mouseOver"
        when: Globals.mouseOverBar
        PropertyChanges {
          target: border
          bottomMarginSize: 0
          cornerRadius: 20
        }
      },
      State {
        name: "noWindows"
        when: (Globals.fullHeight || Globals.noWindows)
        PropertyChanges {
          target: border
          holeMargin: 25
          bottomMarginSize: 0
          cornerRadius: 30
        }
        StateChangeScript {
          script: {
            Globals.marginSize = 25
          }
        }
      },
      State {
        name: "windows"
        when: !Globals.noWindows && !Globals.mouseOverBar
        PropertyChanges {
          target: border
          holeMargin: 10
          bottomMarginSize: -30
          cornerRadius: 22
        }
        StateChangeScript {
          script: {
            Globals.marginSize = 10
          }
        }
      }
    ]
  }
}
