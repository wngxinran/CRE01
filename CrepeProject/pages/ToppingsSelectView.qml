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
        id: veggies
        width: parent.width
        height: parent.height / 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: veggies_selet_title

            text: "Add veggies?"
            font.bold: true
            font.pixelSize: 20
            color: "yellow"
        }

        ColumnLayout {
            id: veggies_column
            anchors.top: veggies_selet_title.bottom
            anchors.topMargin: 10

            // checkbox
            CheckBox {
                id: green_onion
                text: qsTr("Green onion")
                checked: m_selections.onion
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        no_veggies.checked = false;
                    }
                    else if (!cilantro.checked && !sesame.checked) {
                        no_veggies.checked = true;
                    }

                    preview_image.source = show_image();
                }
            }
            CheckBox {
                id: cilantro
                text: qsTr("Cilantro")
                checked: m_selections.cilantro
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        no_veggies.checked = false;
                    }
                    else if (!green_onion.checked && !sesame.checked) {
                        no_veggies.checked = true;
                    }

                    preview_image.source = show_image();
                }
            }
            CheckBox {
                id: sesame
                text: qsTr("Sesame")
                checked: m_selections.sesame
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        no_veggies.checked = false;
                    }
                    else if (!green_onion.checked && !cilantro.checked) {
                        no_veggies.checked = true;
                    }

                    preview_image.source = show_image();
                }
            }
            CheckBox {
                id: no_veggies
                text: qsTr("No veggies")
                checked: !(m_selections.onion || m_selections.cilantro || m_selections.sesame)
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        green_onion.checked = false;
                        cilantro.checked = false;
                        sesame.checked = false;

//                        m_selections.onion = false;
//                        m_selections.cilantro = false;
//                        m_selections.sesame = false;
                    }
                    else {
                        green_onion.checked = true;
                        cilantro.checked = true;
                        sesame.checked = true;
                    }

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

    Component.onCompleted: {
        show_image();
    }

    function is_onion(){
        return green_onion.checked
    }
    function is_cilantro(){
        return cilantro.checked
    }
    function is_sesame(){
        return sesame.checked
    }

    function update_selections() {
        m_selections.onion = green_onion.checked;
        m_selections.cilantro = cilantro.checked;
        m_selections.sesame = sesame.checked;
    }

    function show_image() {
        update_selections();
        // if extra_crispy crepe
        if (m_selections.extra_crispy) {
            if (no_veggies.checked)
                m_image_name = "qrc:/images/crispy_with_eggs.PNG"
            else if (green_onion.checked) {
                if (cilantro.checked) {
                    if (sesame.checked) {
                        m_image_name = "qrc:/images/crispy_sesame_onion_cilantro.PNG"
                    }
                    else {
                        m_image_name = "qrc:/images/crispy_onion_cilantro.PNG"
                    }
                }
                else {
                    if (sesame.checked) {
                        m_image_name = "qrc:/images/crispy_sesame_onion.PNG"
                    }
                    else {
                        m_image_name = "qrc:/images/crispy_onion.PNG"
                    }
                }
            }
            else {
                if (cilantro.checked) {
                    if (sesame.checked) {
                        m_image_name = "qrc:/images/crispy_sesame_cilantro.PNG"
                    }
                    else {
                        m_image_name = "qrc:/images/crispy_cilantro.PNG"
                    }
                }
                else {
                    m_image_name = "qrc:/images/crispy_sesame.PNG"
                }
            }
        }
        // if plain crepe
        else {
            if (no_veggies.checked)
                m_image_name = "qrc:/images/plain_with_eggs.PNG"
            else if (green_onion.checked) {
                if (cilantro.checked) {
                    if (sesame.checked) {
                        m_image_name = "qrc:/images/plain_sesame_onion_cilantro.PNG"
                    }
                    else {
                        m_image_name = "qrc:/images/plain_onion_cilantro.PNG"
                    }
                }
                else {
                    if (sesame.checked) {
                        m_image_name = "qrc:/images/plain_sesame_onion.PNG"
                    }
                    else {
                        m_image_name = "qrc:/images/plain_onion.PNG"
                    }
                }
            }
            else {
                if (cilantro.checked) {
                    if (sesame.checked) {
                        m_image_name = "qrc:/images/plain_sesame_cilantro.PNG"
                    }
                    else {
                        m_image_name = "qrc:/images/plain_cilantro.PNG"
                    }
                }
                else {
                    m_image_name = "qrc:/images/plain_sesame.PNG"
                }
            }
        }

        return m_image_name;
    }

    Component {
        id: checkbox_style

        CheckBoxStyle {
            label: Text
            {
                text: control.text
                font.pixelSize: 20
                anchors.margins: 0
                horizontalAlignment: Text.left
                color: "yellow"
            }
        }
    }



}


