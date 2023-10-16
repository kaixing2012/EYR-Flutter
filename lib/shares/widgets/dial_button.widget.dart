import 'package:flutter/material.dart';
import 'package:flutter_proj/core/alpha_base.mixin.dart';

class DialButtonWidget extends StatelessWidget with AlphaBase {
  final String text;
  final Function(String) onPress;

  DialButtonWidget({
    super.key,
    required this.text,
    required this.onPress,
  });

  ElevatedButton button() => ElevatedButton(
        onPressed: () => onPress(text),
        style: buttonStyle(),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      );

  ButtonStyle buttonStyle() => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width / 4 - (1.5 * 4) - 20,
        height: MediaQuery.of(context).size.width / 4 - (1.5 * 4) - 20,
        margin: const EdgeInsets.all(3),
        child: button(),
      );
}