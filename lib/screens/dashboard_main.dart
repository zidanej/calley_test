
import 'package:material_ui/material_ui.dart';

import 'calling_history_screen.dart';
import 'menu_drawer.dart';

class DashboardMain extends StatefulWidget {
  final String userName;
  final String userEmail;

  const DashboardMain({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  DashboardMainState createState() => DashboardMainState();
}

class DashboardMainState extends State<DashboardMain> {
  int selectedIndex = 2;

  void showCallingListsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.48,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: const BoxDecoration(
                  color: Color(0xFF203568),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: const Text(
                  'CALLING LISTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF5FF),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Select Calling List',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Refresh will be connected to API later',
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Refresh'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2864ED),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF5FF),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Test List',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);

                                Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                    builder: (context) => CallingHistoryScreen(
                                      userName: widget.userName,
                                      userEmail: widget.userEmail,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 22,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // Drawer
      drawer: MenuDrawer(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Dashboard header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Row(
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 34,
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.support_agent,
                      size: 29,
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      size: 29,
                    ),
                  ),
                ],
              ),
            ),

            // Main dashboard content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Welcome card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 22,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2864ED),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFD4DFEF),
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 31,
                            backgroundColor: Color(0xFFE85B78),
                            child: Icon(
                              Icons.person,
                              size: 42,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 17),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello ${widget.userName}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                const Text(
                                  'Welcome to Calley!',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Load number heading
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 25,
                        bottom: 48,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFF203568),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'LOAD NUMBER TO CALL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Upload information card
                    Transform.translate(
                      offset: const Offset(0, -28),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFFD1DCEB),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(
                                20,
                                24,
                                20,
                                12,
                              ),
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(text: 'Visit '),
                                    TextSpan(
                                      text: 'https://app.getcalley.com',
                                      style: TextStyle(
                                        color: Color(0xFF2864ED),
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' to upload numbers that you '
                                          'wish to call using Calley '
                                          'Mobile App.',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // Upload illustration
                            Image.asset(
                              'assets/images/illustration.png',
                              width: double.infinity,
                              height: 330,
                              fit: BoxFit.contain,
                              alignment: Alignment.bottomCenter,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Calling buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.green,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat,
                        color: Color(0xFF4CAF50),
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: ElevatedButton(
                        onPressed: showCallingListsSheet,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2864ED),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Text(
                          'Start Calling Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom navigation
            Container(
              height: 86,
              decoration: const BoxDecoration(
                color: Color(0xFFEDF6FF),
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF2864ED),
                    width: 1.2,
                  ),
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavigationItem(Icons.home_outlined, 0),
                  buildNavigationItem(Icons.contact_page_outlined, 1),
                  buildNavigationItem(Icons.play_arrow, 2),
                  buildNavigationItem(Icons.phone_callback_outlined, 3),
                  buildNavigationItem(Icons.calendar_month_outlined, 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationItem(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: isSelected ? 76 : 48,
        height: isSelected ? 64 : 48,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2864ED)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(
          icon,
          size: isSelected ? 38 : 30,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
