import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Custom Painted Background
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 80),
          painter: NavBarPainter(),
        ),
        // Icons Row
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconButton('assets/icons/House.png', 0),
              iconButton('assets/icons/search.png', 1),
              SizedBox(width: 60), // Space for paw button
              iconButton('assets/icons/Compass.png', 2),
              iconButton('assets/icons/User.png', 3),
            ],
          ),
        ),
        // Floating Paw Button
        Positioned(
          top: -25,
          left: MediaQuery.of(context).size.width / 2 - 30, // Center it
          child: GestureDetector(
            onTap: () => onTap(4),
            child: Container(
              width: 60,
              height: 60,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   shape: BoxShape.circle,
              //   boxShadow: [
              //     BoxShadow(color: Colors.black26, blurRadius: 8),
              //   ],
              // ),
              child: Center(
                child: Image.asset(
                  'assets/icons/Group 10.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconButton(String assetPath, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Image.asset(
        assetPath,
        width: currentIndex == index ? 30 : 26,
        height: currentIndex == index ? 30 : 26,
        color: currentIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}

class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.35, 0)
      ..quadraticBezierTo(
          size.width * 0.40, 0, size.width * 0.40, 20) // Left curve up
      ..arcToPoint(
        Offset(size.width * 0.60, 20),
        radius: Radius.circular(20),
        clockwise: false,
      )
      ..quadraticBezierTo(
          size.width * 0.60, 0, size.width * 0.65, 0) // Right curve down
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
