
import 'package:material_ui/material_ui.dart';
import 'login_screen.dart';

class MenuDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;

  const MenuDrawer({
    super.key,
    this.userName = '',
    this.userEmail = '',
  });

  static const Color primaryBlue = Color(0xFF2864ED);
  static const Color drawerBackground = Color(0xFFEEF4FF);
  static const Color dividerColor = Color(0xFFD0DAE9);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: screenWidth * 0.72,
      backgroundColor: drawerBackground,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              height: 133,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: primaryBlue,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE85E7C),
                    child: Icon(
                      Icons.person,
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                userName.isEmpty ? 'User' : userName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '• Personal',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFFFFC04D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFDCE6FF),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Menu
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    buildMenuItem(
                      context,
                      icon: Icons.rocket_launch_outlined,
                      title: 'Getting Started',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.cloud_sync_outlined,
                      title: 'Sync Data',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.grid_view_outlined,
                      title: 'Gamification',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.phone_in_talk_outlined,
                      title: 'Send Logs',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.headset_mic_outlined,
                      title: 'Help?',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.person_remove_outlined,
                      title: 'Cancel Subscription',
                    ),

                    const SizedBox(height: 5),

                    const Divider(
                      color: dividerColor,
                      thickness: 1,
                      height: 1,
                    ),

                    // App Info Heading
                    const Padding(
                      padding: EdgeInsets.fromLTRB(28, 22, 12, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'App Info',
                          style: TextStyle(
                            color: primaryBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.badge_outlined,
                      title: 'About Us',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.policy_outlined,
                      title: 'Privacy Policy',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.newspaper_outlined,
                      title: 'Version 1.01.52',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.share_outlined,
                      title: 'Share App',
                    ),

                    buildMenuItem(
                      context,
                      icon: Icons.logout_outlined,
                      title: 'Logout',
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return InkWell(
      onTap: () {
        if (title == 'Logout') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 8,
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.055),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 23,
                color: Colors.black,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
