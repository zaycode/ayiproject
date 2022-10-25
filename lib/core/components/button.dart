import 'package:ayi/config/app_color.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Key? buttonKey;
  final bool enable;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  const Button({
    Key? key,
    required this.title,
    this.onTap,
    this.margin,
    this.enable = true,
    this.bgColor,
    this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: TextButton(
        key: buttonKey,
        onPressed: enable ? onTap : null,
        style: TextButton.styleFrom(
          backgroundColor:
              enable ? (bgColor ?? AppColors.primary) : AppColors.disable,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(color: AppColors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
