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
    readonly property color primaryColor: "#4285F4" // Chrome Blue
    readonly property color primaryLightColor: "#82B1FF"
    readonly property color primaryDarkColor: "#3367D6"

    // Secondary Colors
    readonly property color secondaryColor: "#1A73E8" // Secondary Blue
    readonly property color secondaryLightColor: "#63A4FF"
    readonly property color secondaryDarkColor: "#004BA0"

    // Surface Colors
    readonly property color backgroundColor: "#FFFFFF" // White for clean UI
    readonly property color surfaceColor: "#F1F3F4" // Light Gray for surfaces
    readonly property color errorColor: "#EA4335" // Chrome Red for errors

    // Text Colors
    readonly property color textColorPrimary: "#202124" // Dark Chrome Gray
    readonly property color textColorSecondary: "#5F6368" // Lighter Gray
    readonly property color textColorOnPrimary: "#FFFFFF" // White on primary
    readonly property color textColorOnSecondary: "#FFFFFF" // White on secondary

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
    readonly property color buttonColorPrimary: primaryColor
    readonly property color buttonColorSecondary: secondaryColor
    readonly property color buttonTextColor: textColorOnPrimary
    readonly property color buttonPressedColor: primaryDarkColor



    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../RosQML2Content/" + relativeFontDirectory)
    }
}
