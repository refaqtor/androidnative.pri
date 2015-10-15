import QtQuick 2.0
import QuickAndroid 0.1

Style {
    id: style

    property TextStyle text : TextStyle {
        textSize: 16 * A.dp
        textColor: Constants.black87
        disabledTextColor: Constants.black54
    }

    // The color of underline and floating text label on active.
    property string color

    property string disabledColor : Constants.black54

    property string inactiveColor : Constants.black54
}

