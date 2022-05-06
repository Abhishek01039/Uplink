import 'package:flutter/material.dart';
import 'package:ui_library/ui_library_export.dart';

enum _ButtonType { primary, secondary, filled1, filled2 }

class UButton extends StatelessWidget {
  final _ButtonType _buttonType;
  final String? _label;
  final UIconData? _uIconData;
  final VoidCallback _onPressed;

  ///[ElevatedButton] with Text and Icon:
  ///```dart
  /// UButton.primary(
  ///    label: 'ButtonText',
  ///    uIconData: UIcons.about,
  ///    onPressed: () {},
  ///  )
  ///```
  const UButton.primary(
      {Key? key,
      required String label,
      required UIconData uIconData,
      required VoidCallback onPressed})
      : _buttonType = _ButtonType.primary,
        _label = label,
        _uIconData = uIconData,
        _onPressed = onPressed,
        super(key: key);

  ///[ElevatedButton] with Text and Icon:
  ///```dart
  /// UButton.secondary(
  ///    label: 'ButtonText',
  ///    uIconData: UIcons.about,
  ///    onPressed: () {},
  ///  )
  ///```
  const UButton.secondary(
      {Key? key,
      required String label,
      required UIconData uIconData,
      required VoidCallback onPressed})
      : _buttonType = _ButtonType.secondary,
        _label = label,
        _uIconData = uIconData,
        _onPressed = onPressed,
        super(key: key);

  ///[ElevatedButton] with Text only:
  ///```dart
  /// UButton.filled1(
  ///    label: 'ButtonText',
  ///    onPressed: () {},
  ///  )
  ///```
  const UButton.filled1(
      {Key? key, required String label, required VoidCallback onPressed})
      : _buttonType = _ButtonType.filled1,
        _label = label,
        _uIconData = null,
        _onPressed = onPressed,
        super(key: key);

  ///[ElevatedButton] with Text only:
  ///```dart
  /// UButton.filled2(
  ///    label: 'ButtonText',
  ///    onPressed: () {},
  ///  )
  ///```
  const UButton.filled2(
      {Key? key, required String label, required VoidCallback onPressed})
      : _buttonType = _ButtonType.filled2,
        _label = label,
        _uIconData = null,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(50, 40),
            primary: (_buttonType == _ButtonType.primary) ||
                    (_buttonType == _ButtonType.filled1)
                ? UColors.ctaBlue
                : UColors.ctaDark,
            padding: (_buttonType == _ButtonType.primary) ||
                    (_buttonType == _ButtonType.secondary)
                ? const EdgeInsets.fromLTRB(16, 8, 24, 8)
                : const EdgeInsets.fromLTRB(24, 13, 24, 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: _onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_uIconData != null) UIcon(_uIconData!),
            if (_uIconData != null && _label != null) const SizedBox(width: 8),
            if (_label != null)
              UText(
                _label!,
                textStyle: UTextStyle.BUT1_button,
              ),
          ],
        ));
  }
}