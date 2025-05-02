import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ConvexAppBar(
        items: [
          TabItem(
            icon: Transform.scale(
              scale: 1.1,
              child: SvgPicture.asset(
                selectedIndex == 0
                    ? 'assets/icons/home_icon_selected.svg'
                    : 'assets/icons/home_icon.svg',
                color: selectedIndex == 0 ? Colors.white : Colors.grey,
                width: 24,
                height: 24,
              ),
            ),
          ),
          TabItem(
            icon: Transform.scale(
              scale: 1.1,
              child: SvgPicture.asset(
                selectedIndex == 1
                    ? 'assets/icons/search_icon_selected.svg'
                    : 'assets/icons/search_icon.svg',
                color: selectedIndex == 1 ? Colors.white : Colors.grey,
                width: 24,
                height: 24,
              ),
            ),
          ),
          TabItem(
            icon: Transform.scale(
              scale: 0.8,
              child: SvgPicture.asset(
                'assets/icons/pets_icon.svg',
                color: const Color.fromARGB(255, 0, 0, 0),
                width: 24,
                height: 24,
              ),
            ),
          ),
          TabItem(
            icon: Transform.scale(
              scale: 1.3,
              child: SvgPicture.asset(
                selectedIndex == 3
                    ? 'assets/icons/explore_icon_selected.svg'
                    : 'assets/icons/explore_icon.svg',
                color: selectedIndex == 3 ? Colors.white : Colors.grey,
                width: 24,
                height: 24,
              ),
            ),
          ),
          TabItem(
            icon: Transform.scale(
              scale: 1,
              child: SvgPicture.asset(
                selectedIndex == 4
                    ? 'assets/icons/profile_icon_selected.svg'
                    : 'assets/icons/profile_icon.svg',
                color: selectedIndex == 4 ? Colors.white : Colors.grey,
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
        initialActiveIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        color: const Color.fromARGB(255, 255, 255, 255),
        style: TabStyle.fixedCircle,
        height: 65,
        curveSize: 90,
        top: -30,
        cornerRadius: 35,
        elevation: 4,
      ),
    );
  }
}
