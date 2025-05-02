import 'package:flutter/material.dart';

enum CustomButtonVariant {
  filled,
  outlined,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final CustomButtonVariant variant;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool disabled;
  final bool fullWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = CustomButtonVariant.filled,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
    this.prefixIcon,
    this.suffixIcon,
    this.fontSize,
    this.fontWeight,
    this.disabled = false,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    // Default styles based on variant
    final defaultBackgroundColor = variant == CustomButtonVariant.filled
        ? Colors.black
        : Colors.transparent;
    final defaultTextColor =
        variant == CustomButtonVariant.filled ? Colors.white : Colors.black;
    final defaultBorderColor = Colors.black;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: fullWidth ? double.infinity : width,
        height: height ?? 56,
        child: variant == CustomButtonVariant.filled
            ? ElevatedButton(
                onPressed: disabled ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor ?? defaultBackgroundColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 28),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: _buildButtonContent(defaultTextColor),
              )
            : OutlinedButton(
                onPressed: disabled ? null : onPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: backgroundColor ?? Colors.white,
                  elevation: 0,
                  side: BorderSide(
                    color: borderColor ?? defaultBorderColor,
                    width: borderWidth ?? 3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 28),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: _buildButtonContent(defaultTextColor),
              ),
      ),
    );
  }

  Widget _buildButtonContent(Color defaultTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: textColor ?? defaultTextColor,
            fontSize: fontSize ?? 20,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: 8),
          suffixIcon!,
        ],
      ],
    );
  }
}
