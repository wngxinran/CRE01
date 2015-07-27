import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
// Grid Layout
import QtQuick.Layouts 1.1

Item {

    property color backgroud_color: "transparent"
    // default users selections
    property var m_selections: { 'gluten_free':   false,
                                 'extra_crispy':  false,
                                 'number_of_eggs': 1,
                                 'onion':         true,
                                 'cilantro':      true,
                                 'sesame':        true,
                                 'wonton':        true,
                                 'hotdog':        true,
                                 'sweet':         false,
                                 'spicy':         true

    }

    property string m_image_name

    Rectangle {
        id: sauces
        width: parent.width
        height: parent.height / 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: sauces_selet_title

            text: "What kind of sauces?"
            font.bold: true
            font.pixelSize: 20
            color: "yellow"
        }

        ColumnLayout {
            id: sauces_column
            anchors.top: sauces_selet_title.bottom
            anchors.topMargin: 10

            ExclusiveGroup { id: sauces_sel_group }

            RadioButton {
                id: spicy
                text: "Spicy"
                checked: m_selections.spicy
                exclusiveGroup: sauces_sel_group
                style: radio_button_style

                onClicked: {
                    preview_image.source = show_image();
                }
            }
            RadioButton {
                id: sweet
                text: "Sweet"
                checked: !m_selections.spicy
                exclusiveGroup: sauces_sel_group
                style: radio_button_style

                onClicked: {
                    preview_image.source = show_image();
                }
            }

        }
    }

    Rectangle {
        id: preview
        width: parent.width
        height: parent.height / 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        Image {
            id: preview_image
            source: m_image_name
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }

    }

    Text {
        id: no_worries
        text: "No worries, your veggies are on the other side"
        font.pixelSize: 20
        anchors.bottom: preview.top
        horizontalAlignment: Text.left
        color: "yellow"
    }

    Component.onCompleted: {
        show_image();
    }

    function is_spicy()
    {
        return spicy.checked
    }

    function is_sweet()
    {
        return sweet.checked
    }

    function update_selections() {
        m_selections.spicy = spicy.checked;
        m_selections.sweet = sweet.checked;
    }

    function show_image() {
        update_selections();
        if (m_selections.spicy) {
            m_image_name = m_selections.extra_crispy ?
                        "qrc:/images/crispy_spicy.PNG" : "qrc:/images/plain_spicy.PNG"
        }
        else {
            m_image_name = m_selections.extra_crispy ?
                        "qrc:/images/crispy_sweet.PNG" : "qrc:/images/plain_sweet.PNG"
        }

        return m_image_name;
    }

    Component {
        id: radio_button_style

        RadioButtonStyle {
            label: Text
            {
            text: control.text
            font.pixelSize: 20
            anchors.margins: 0
            horizontalAlignment: Text.left
            color: "yellow"
        }

        indicator: Rectangle {
            implicitWidth: 16
            implicitHeight: 16
            radius: 9
            border.color: control.activeFocus ? "darkblue" : "gray"
            border.width: 1
            Rectangle {
                anchors.fill: parent
                visible: control.checked
                color: "#555"
                radius: 9
                anchors.margins: 4
            }
        }
    }
}

}


