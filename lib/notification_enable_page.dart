import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';

class NotificationEnablePage extends StatelessWidget {
  const NotificationEnablePage({Key? key}) : super(key: key);

  void _onEnableNotifications(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/notification_enable.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Enable Notifications",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Enable notifications for reminders and messages",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: "Enable",
                  onPressed: () => _onEnableNotifications(context),
                  backgroundColor: const Color(0xFFB38E5D),
                  textColor: Colors.white,
                  borderRadius: 30,
                  height: 50,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Skip for now",
                  onPressed: () => _onEnableNotifications(context),
                  variant: CustomButtonVariant.outlined,
                  borderColor: Colors.black,
                  borderWidth: 2,
                  borderRadius: 30,
                  height: 50,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
