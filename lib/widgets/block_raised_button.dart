import 'package:flutter/material.dart';
import 'package:photo_pdf/constants.dart';

class BlockRaisedButton extends StatelessWidget {
  final String label;
  final Color? textColor;
  final Color? color;
  final double? fontSize;
  final Function? action;
  final Color? borderColor;

  const BlockRaisedButton({
    super.key,
    required this.label,
    this.action,
    this.textColor,
    this.color,
    this.fontSize,
    this.borderColor,
  });

  void onPressed() {
    if (action != null) {
      action!();
    }
  } 

  @override
  Widget build(BuildContext context) {
    var color = this.color?? primaryColor;
    var textColor = this.textColor?? Colors.white;
    var fontSize = this.fontSize?? 18.0;
    var borderColor = this.borderColor ?? Colors.transparent;

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: textColor,
      backgroundColor: color,
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        side: BorderSide(color: borderColor, width: 2),
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: onPressed,
        child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            )
      ),
    );
  }
}
