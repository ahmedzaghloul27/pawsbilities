import 'package:flutter/material.dart';
import 'package:pawsbilities_app/welcome_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'set_location_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: SvgPicture.asset('assets/icons/settings_profile_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'Your account',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'See information about your account.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const YourAccountPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/matching_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'Matching Preferences',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Set your match distance, location, etc.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const MatchPreferencesPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/Lock_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'Two-factor authentication',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Require a second authentication method.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const TwoFactorAuthPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/Bell_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Select the notifications you get.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const NotificationsPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/Help_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'Help center',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Get in touch and we will help you.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const HelpCenterPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/faq_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'FAQ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Your guide to finding the perfect match.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const FAQPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/Info_icon.svg',
                width: 26, height: 26),
            title: const Text(
              'About',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text(
              'Know more about Pawsibilities.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () => _navigateTo(context, const AboutPage()),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 2,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Sign out',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => _navigateTo(context, const WelcomePage()),
          ),
        ],
      ),
    );
  }
}

class YourAccountPage extends StatelessWidget {
  const YourAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Your account',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          _SettingsExpansionTile(
            title: 'Account info',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const AccountInfoPage(),
              ));
            },
            child: SizedBox.shrink(),
          ),
          const Divider(indent: 16, endIndent: 16, height: 2),
          _SettingsExpansionTile(
            title: 'Change email',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ChangeEmailPage(),
              ));
            },
            child: SizedBox.shrink(),
          ),
          const Divider(indent: 16, endIndent: 16, height: 2),
          _SettingsExpansionTile(
            title: 'Change password',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ChangePasswordPage(),
              ));
            },
            child: SizedBox.shrink(),
          ),
          const Divider(indent: 16, endIndent: 16, height: 2),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                const Icon(Icons.delete_outline, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Delete account',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsExpansionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget child;
  const _SettingsExpansionTile(
      {required this.title, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      trailing:
          const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [child],
      onExpansionChanged: (expanded) {
        if (expanded) onTap();
      },
    );
  }
}

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: const Text(
              'Change email',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _RoundedTextField(hint: 'New email'),
                  const SizedBox(height: 16),
                  _RoundedTextField(hint: 'Confirm new email'),
                  const SizedBox(height: 16),
                  _RoundedTextField(
                    hint: 'Current password',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Complete',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: const Text(
              'Change password',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _RoundedTextField(
                    hint: 'Current password',
                    obscureText: _obscureCurrent,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrent
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureCurrent = !_obscureCurrent;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _RoundedTextField(
                    hint: 'New password',
                    obscureText: _obscureNew,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNew ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNew = !_obscureNew;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _RoundedTextField(
                    hint: 'Confirm new password',
                    obscureText: _obscureConfirm,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Complete',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: const Text(
              'Account info',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _RoundedTextField(
                    hint: 'Email Address',
                    initialValue: 'ahmedzaghloul528@yahoo.com',
                  ),
                  const SizedBox(height: 16),
                  _RoundedTextField(
                    hint: 'First name',
                    initialValue: 'Ahmed',
                  ),
                  const SizedBox(height: 16),
                  _RoundedTextField(
                    hint: 'Last name',
                    initialValue: 'Zaghloul',
                  ),
                  const SizedBox(height: 16),
                  _RoundedTextField(
                    hint: 'Date of birth',
                    initialValue: '27/9/2002',
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today_outlined,
                          color: Colors.grey),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final String hint;
  final String? initialValue;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  const _RoundedTextField({
    required this.hint,
    this.initialValue,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.grey, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
    );
  }
}

class MatchPreferencesPage extends StatefulWidget {
  const MatchPreferencesPage({super.key});

  @override
  _MatchPreferencesPageState createState() => _MatchPreferencesPageState();
}

class _MatchPreferencesPageState extends State<MatchPreferencesPage> {
  String _location = 'Alexandria, Miami';
  double _distance = 30;
  bool _showFurtherAway = false;
  RangeValues _ageRange = const RangeValues(1, 16);

  @override
  Widget build(BuildContext context) {
    return _StickyScaffold(
      title: 'Match preferences',
      slivers: [
        _MatchPreferencesBody(
          location: _location,
          distance: _distance,
          showFurtherAway: _showFurtherAway,
          onLocationChanged: (val) => setState(() => _location = val as String),
          onDistanceChanged: (val) => setState(() => _distance = val),
          onShowFurtherAwayChanged: (val) =>
              setState(() => _showFurtherAway = val),
          ageRange: _ageRange,
          onAgeRangeChanged: (values) => setState(() => _ageRange = values),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _StickyScaffold extends StatelessWidget {
  final String title;
  final List<Widget> slivers;
  const _StickyScaffold({required this.title, required this.slivers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            backgroundColor: Colors.white,
            elevation: 0.5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          ...slivers,
        ],
      ),
    );
  }
}

class _MatchPreferencesBody extends StatefulWidget {
  final String location;
  final double distance;
  final bool showFurtherAway;
  final ValueChanged<String?> onLocationChanged;
  final ValueChanged<double> onDistanceChanged;
  final ValueChanged<bool> onShowFurtherAwayChanged;
  final RangeValues? ageRange;
  final ValueChanged<RangeValues>? onAgeRangeChanged;
  const _MatchPreferencesBody({
    required this.location,
    required this.distance,
    required this.showFurtherAway,
    required this.onLocationChanged,
    required this.onDistanceChanged,
    required this.onShowFurtherAwayChanged,
    this.ageRange,
    this.onAgeRangeChanged,
  });
  @override
  State<_MatchPreferencesBody> createState() => _MatchPreferencesBodyState();
}

class _MatchPreferencesBodyState extends State<_MatchPreferencesBody> {
  RangeValues _ageRange = const RangeValues(1, 16);
  String? _currentLocationName;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationName();
  }

  Future<void> _getCurrentLocationName() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final googlePlace =
          GooglePlace('AIzaSyD4JvQ5V1FZHEAtCluWpb8l0y3o-PJS7K8');
      final response = await googlePlace.search.getNearBySearch(
        Location(lat: position.latitude, lng: position.longitude),
        1,
      );
      String name = 'Current Location';
      if (response != null &&
          response.results != null &&
          response.results!.isNotEmpty) {
        name = response.results!.first.name ?? name;
      }
      setState(() {
        _currentLocationName = name;
      });
    } catch (e) {
      setState(() {
        _currentLocationName = 'Current Location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetLocationPage(),
                    ),
                  );
                  if (result != null &&
                      result is Map &&
                      result['name'] != null) {
                    setState(() {
                      _currentLocationName = result['name'];
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[700], size: 20),
                    const SizedBox(width: 6),
                    Text(
                      _currentLocationName ?? 'Detecting location...',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const _SectionHeader('Preferred distance'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Preferred distance'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('${widget.distance.round()} km'),
            ),
          ],
        ),
        Slider(
          value: widget.distance,
          min: 2,
          max: 100,
          divisions: 98,
          activeColor: Theme.of(context).primaryColor,
          onChanged: widget.onDistanceChanged,
        ),
        const Divider(indent: 16, endIndent: 16, height: 4),
        const _SectionHeader('Preferred age range'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Preferred age range'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                _ageRange.end == 16
                    ? '${_ageRange.start.round()} - 15+ years'
                    : '${_ageRange.start.round()} - ${_ageRange.end.round()} years',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        RangeSlider(
          values: _ageRange,
          min: 1,
          max: 16,
          divisions: 15,
          activeColor: Theme.of(context).primaryColor,
          labels: RangeLabels(
            '${_ageRange.start.round()}',
            _ageRange.end == 16 ? '15+' : '${_ageRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() {
              _ageRange = values;
            });
            if (widget.onAgeRangeChanged != null) {
              widget.onAgeRangeChanged!(values);
            }
          },
        ),
        const Divider(indent: 16, endIndent: 16, height: 4),
        const _SectionHeader('Show pets further away'),
        SwitchListTile(
          title: const Text('Show pets further away if I run out of profiles'),
          value: widget.showFurtherAway,
          activeColor: Theme.of(context).primaryColor,
          onChanged: widget.onShowFurtherAwayChanged,
        ),
      ]),
    );
  }
}

class TwoFactorAuthPage extends StatefulWidget {
  const TwoFactorAuthPage({super.key});

  @override
  State<TwoFactorAuthPage> createState() => _TwoFactorAuthPageState();
}

class _TwoFactorAuthPageState extends State<TwoFactorAuthPage> {
  bool _is2FAEnabled = false;

  @override
  Widget build(BuildContext context) {
    return _StickyScaffold(
      title: '2-FA',
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const _SectionHeader('Enable Two factor authentication'),
            SwitchListTile(
              title: const Text('Require a second authentication method.'),
              value: _is2FAEnabled,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                setState(() {
                  _is2FAEnabled = value;
                });
              },
            ),
          ]),
        ),
      ],
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool likesMatches = true;
  bool newMessages = true;
  bool foundPetAlert = true;
  bool likesOnPosts = true;
  bool likesOnComments = true;
  bool commentsOnPosts = true;
  bool postRecommendations = true;

  @override
  Widget build(BuildContext context) {
    return _StickyScaffold(
      title: 'Notifications',
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const _SectionHeader('Likes & Matches'),
            SwitchListTile(
              title: const Text('Likes & Matches'),
              value: likesMatches,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => likesMatches = value),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('New messages'),
            SwitchListTile(
              title: const Text('New messages'),
              value: newMessages,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => newMessages = value),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('Found pet alert'),
            SwitchListTile(
              title: const Text('Found pet alert'),
              value: foundPetAlert,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => foundPetAlert = value),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('Likes on your posts'),
            SwitchListTile(
              title: const Text('Likes on your posts'),
              value: likesOnPosts,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => likesOnPosts = value),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('Likes on your comments'),
            SwitchListTile(
              title: const Text('Likes on your comments'),
              value: likesOnComments,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => likesOnComments = value),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('Comments on your posts'),
            SwitchListTile(
              title: const Text('Comments on your posts'),
              value: commentsOnPosts,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => commentsOnPosts = value),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('Posts recommendation'),
            SwitchListTile(
              title: const Text('Posts recommendation'),
              value: postRecommendations,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => postRecommendations = value),
            ),
          ]),
        ),
      ],
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _StickyScaffold(
      title: 'Help Center',
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const _SectionHeader('Contact us'),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text(
                'contact@pawsibilities.com',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _StickyScaffold(
      title: 'FAQ',
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const _SectionHeader('Getting Started'),
            const ListTile(
              title: Text('Download and Install'),
              subtitle: Text(
                  'Find the app on the App Store or Google Play and install it.'),
            ),
            const ListTile(
              title: Text('Sign Up'),
              subtitle: Text(
                  'Create an account using email, phone, or social media.'),
            ),
            const ListTile(
              title: Text('Create Your Profile'),
              subtitle: Text(
                  'Add personal and pet details including name, breed, and age.'),
            ),
            const Divider(indent: 16, endIndent: 16, height: 2),
            const _SectionHeader('How to Use the App'),
            const ListTile(
              title: Text('Browsing Matches'),
              subtitle:
                  Text('Use filters to find potential matches for your pet.'),
            ),
            const ListTile(
              title: Text('Messaging'),
              subtitle:
                  Text('Chat with other pet owners after a mutual match.'),
            ),
            const ListTile(
              title: Text('Notifications'),
              subtitle:
                  Text('Stay updated with new matches, messages, and alerts.'),
            ),
          ]),
        ),
      ],
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _StickyScaffold(
      title: 'About',
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const _SectionHeader('About the Pet Mating App'),
            const Text(
              'The Pet Mating App helps pet owners find suitable mates for their pets. '
              'It ensures responsible pet breeding while creating a community of pet lovers.',
            ),
            SizedBox(height: 20),
            const Text(
              'Key Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            const Text(
                '- Personalized pet profiles with breed, age, and health details.'),
            const Text(
                '- Smart Matching based on breed, location, and preferences.'),
            const Text(
                '- Secure Messaging for safe communication between pet owners.'),
            const Text('- Health Record Sharing for transparency.'),
            const Text('- Subscription options for premium features.'),
          ]),
        ),
      ],
    );
  }
}
