import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import 'menu_drawer.dart';

class CallingHistoryScreen extends StatelessWidget {
  final String userName;
  final String userEmail;

  const CallingHistoryScreen({
    super.key,
    this.userName = '',
    this.userEmail = '',
  });

  static const Color primaryBlue = Color(0xFF2864ED);
  static const Color darkBlue = Color(0xFF203568);
  static const Color pageBackground = Color(0xFFF7F9FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      drawer: MenuDrawer(userName: userName, userEmail: userEmail),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
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
                          size: 32,
                          color: Colors.black87,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.support_agent, size: 28),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, size: 28),
                  ),
                ],
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final chartSize = math.min(screenWidth * 0.57, 370.0);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                    child: Column(
                      children: [
                        // Calling list summary
                        Container(
                          width: double.infinity,
                          height: 164,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFDCE3EC),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Test List',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '50',
                                          style: TextStyle(
                                            color: primaryBlue,
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'CALLS',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 92,
                                height: 92,
                                decoration: BoxDecoration(
                                  color: primaryBlue,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'S',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 65),

                        // Analytics chart
                        SizedBox(
                          width: chartSize,
                          height: chartSize,
                          child: CustomPaint(
                            painter: CallingChartPainter(),
                            child: Center(
                              child: Container(
                                width: chartSize * 0.47,
                                height: chartSize * 0.47,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3F5F8),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 70),

                        // Status cards
                        Row(
                          children: [
                            Expanded(
                              child: buildStatusCard(
                                title: 'Pending',
                                count: '28',
                                color: const Color(0xFFFFAA38),
                                background: const Color(0xFFFFF1D9),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildStatusCard(
                                title: 'Done',
                                count: '22',
                                color: const Color(0xFF00B82E),
                                background: const Color(0xFFDCF9E0),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildStatusCard(
                                title: 'Schedule',
                                count: '09',
                                color: const Color(0xFF5425E8),
                                background: const Color(0xFFF2ECFC),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Start calling button
                        SizedBox(
                          width: double.infinity,
                          height: 78,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: const Text(
                              'Start Calling Now',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusCard({
    required String title,
    required String count,
    required Color color,
    required Color background,
  }) {
    return Container(
      height: 132,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 92,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Calls',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ],
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

// Clean circular analytics chart
class CallingChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 48;
    const double gap = 0.065;

    final Rect chartRect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final double availableAngle = (2 * math.pi) - (gap * 3);

    final double blueSweep = availableAngle * 0.50;
    final double purpleSweep = availableAngle * 0.16;
    final double orangeSweep = availableAngle * 0.34;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    double startAngle = -math.pi / 2 + gap / 2;

    // Blue - Done
    paint.color = const Color(0xFF2676EC);
    canvas.drawArc(chartRect, startAngle, blueSweep, false, paint);

    startAngle += blueSweep + gap;

    // Purple - Schedule
    paint.color = const Color(0xFF9560EF);
    canvas.drawArc(chartRect, startAngle, purpleSweep, false, paint);

    startAngle += purpleSweep + gap;

    // Orange - Pending
    paint.color = const Color(0xFFFFAA38);
    canvas.drawArc(chartRect, startAngle, orangeSweep, false, paint);
  }

  @override
  bool shouldRepaint(covariant CallingChartPainter oldDelegate) {
    return false;
  }
}
