import 'package:flutter/material.dart';

class StickyHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const StickyHeader({
    super.key,
    required this.title,
    this.trailing,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:80,
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
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
