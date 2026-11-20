// import 'package:material_ui/material_ui.dart';
// import 'screens/language_selection_screen.dart';
// import 'screens/registration_screen.dart';
// import 'screens/email_otp_verification_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/dashboard_screen.dart';
// import 'screens/dashboard_main.dart';
// import 'screens/calling_history_screen.dart';
// import 'screens/menu_drawer.dart';


// void main() {
//   runApp(const CalleyApp());
// }

// class CalleyApp extends StatelessWidget {
//   const CalleyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Calley',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       // home: const LanguageSelectionScree(),
//       // home: const RegistrationScreen(),
//       // home: const EmailOtpVerificationScreen(),
//       // home: const LoginScreen(),
//       // home: const DashboardScreen(),
//       // home: const DashboardMain(),
//       // home: const CallingHistoryScreen(),
//       home: const MenuDrawer(),
//     );
//   }
// }

import 'package:material_ui/material_ui.dart';

import 'screens/language_selection_screen.dart';

void main() {
  runApp(const CalleyApp());
}

class CalleyApp extends StatelessWidget {
  const CalleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calley',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}
