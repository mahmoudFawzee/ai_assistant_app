import 'package:flutter/material.dart';
part 'margin_manger.dart';
part 'padding_manger.dart';
part 'sizes_manger.dart';

final class ResponsivenessManger {
  final BuildContext context;
  ResponsivenessManger(this.context) {
    margin = _MarginManger(context);
    padding = _PaddingManger(context);
    sizes = _SizesManger(context);
  }
  late _MarginManger margin;
  late _PaddingManger padding;
  late _SizesManger sizes;
}

class _RsManger {
  final BuildContext context;
  late double _screenHeight;
  late double _screenWidth;
  //?this is the height in the design
  static const _designHeight = 844;
  //?this is the width in the design
  static const _designWidth = 390;
  _RsManger(this.context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
  }

  //!===> our design height (480)              design padding(10)
  //!===> our mobile screen height           mobile padding which will be equals the {10 padding}
  //! wanted padding = (design padding * our mobile screen height) / design height
  double _getHeight(double designHeight) =>
      (designHeight * _screenHeight) / _designHeight;
  double _getWidth(double designWidth) =>
      (designWidth * _screenWidth) / _designWidth;
}
