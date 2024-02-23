import 'dart:ui';

class ColorsConverter {
  /// Transforms a RGBA value (css style) to a ARGB value
  /// for dart Color widgets.
  ///
  /// e.g Utils.toDartColor('#0073E6')
  static int toDartColor(String cssHexColor) {
    var hexRGBValue = int.parse('0x${cssHexColor.replaceAll("#", "")}');
    // Detect if RGB only, without alpha channel
    if (hexRGBValue <= 0xffffff) {
      // transform it to a ARGB value with max opacity
      return hexRGBValue | 0xff000000;
    }
    // else discard the trail alpha value and add it as first channel
    return hexRGBValue >> 8 | 0xff000000;
  }

  /// Transforms a RGBA value (css style) to a Dart Color widget.
  ///
  /// e.g Color a = Utils.toDartColorWidget('#0073E6')
  static Color toDartColorWidget(String cssHexColor) {
    return Color(toDartColor(cssHexColor));
  }
}
