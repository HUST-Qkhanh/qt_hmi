pragma Singleton
import QtQuick 6.7
import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1920
    readonly property int height: 1080

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })
    // Primary Colors
    readonly property color primaryColor: "#B0C4DE" // Chrome Blue
    readonly property color primaryLightColor: "#D1E1F6"
    readonly property color primaryDarkColor: "#4B505A"

    // Secondary Colors
    readonly property color secondaryColor: "#1A73E8" // Secondary Blue
    readonly property color secondaryLightColor: "#63A4FF"
    readonly property color secondaryDarkColor: "#004BA0"

    // Surface Colors
    readonly property color backgroundColor: "white" // White for clean UI
    readonly property color surfaceColor: "#D8D8D8" // Light Gray for surfaces
    readonly property color errorColor: "#EA4335" // Chrome Red for errors

    // Text Colors
    readonly property color textColorPrimary: "#202124" // Dark Chrome Gray
    readonly property color textColorSecondary: "#5F6368" // Lighter Gray
    readonly property color textColorOnPrimary: "#202124" // White on primary
    readonly property color textColorOnSecondary: "#1A73E8" // White on secondary

    // Font Sizes (sp - scalable pixels)
    readonly property int fontSizeSmall: 12
    readonly property int fontSizeMedium: 16
    readonly property int fontSizeLarge: 20
    readonly property int fontSizeExtraLarge: 24

    // Elevation and Shadow (Z-axis depth effect)
    readonly property int elevationLow: 2
    readonly property int elevationMedium: 8
    readonly property int elevationHigh: 16

    // Border Radius
    readonly property int borderRadiusSmall: 4
    readonly property int borderRadiusMedium: 8
    readonly property int borderRadiusLarge: 12

    // Padding and Margin
    readonly property int paddingSmall: 8
    readonly property int paddingMedium: 16
    readonly property int paddingLarge: 24

    // Opacity levels for disabled components
    readonly property real disabledOpacity: 0.38

    // Typography (default font family)
    readonly property string fontFamily: "Roboto"

    // Button Colors and Styles
    readonly property color buttonColorPrimary: "#F5F5F5"
    readonly property color buttonColorSecondary: primaryColor
    readonly property color buttonTextColor: textColorOnPrimary
    readonly property color buttonTextColorSecondary: textColorPrimary
    readonly property color buttonPressedColor: primaryDarkColor



    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../RosQML2Content/" + relativeFontDirectory)
    }
}
