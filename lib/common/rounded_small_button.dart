import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class RoundedSmallButton extends StatelessWidget {
  final VoidCallback onTab;
  final Color backgroundColor;
  final Color textColor;
  final String label;

  const RoundedSmallButton(
      {super.key,
      required this.onTab,
      required this.label,
      this.backgroundColor = Pallete.whiteColor,
      this.textColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      backgroundColor: backgroundColor,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }
}
