import 'package:flutter/material.dart';

class ThreeItemHeader extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const ThreeItemHeader({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left item with proper alignment
            SizedBox(
              width: 60,
              child: leading != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: leading!,
                    )
                  : const SizedBox.shrink(),
            ),

            // Center item (title)
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Right item with proper alignment
            SizedBox(
              width: 60,
              child: trailing != null
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: trailing!,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
