import 'package:material_ui/material_ui.dart';

import '../models/language_option.dart';
import 'registration_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      LanguageSelectionScreenState();
}

class LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // All available languages
  final List<LanguageOption> languages = const [
    LanguageOption(name: 'English', subtitle: 'Hi', code: 'en'),
    LanguageOption(name: 'Hindi', subtitle: 'नमस्ते', code: 'hi'),
    LanguageOption(name: 'Bengali', subtitle: 'হ্যালো', code: 'bn'),
    LanguageOption(name: 'Kannada', subtitle: 'ನಮಸ್ಕಾರ', code: 'kn'),
    LanguageOption(name: 'Punjabi', subtitle: 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ', code: 'pa'),
    LanguageOption(name: 'Tamil', subtitle: 'வணக்கம்', code: 'ta'),
    LanguageOption(name: 'Telugu', subtitle: 'హలో', code: 'te'),
    LanguageOption(name: 'French', subtitle: 'Bonjour', code: 'fr'),
    LanguageOption(name: 'Spanish', subtitle: 'Hola', code: 'es'),
  ];

  // English is selected by default
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                'Choose Your Language',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 16),

              // White language selection card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD3DEEC)),
                  ),

                  child: ListView.builder(
                    itemCount: languages.length,

                    itemBuilder: (context, index) {
                      final language = languages[index];

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedLanguage = language.code;
                          });
                        },

                        child: SizedBox(
                          height: 60,

                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(language.name),
                                    Text(
                                      language.subtitle,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Radio<String>(
                                value: language.code,
                                groupValue: selectedLanguage,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLanguage = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Select button
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2862ED),
                    foregroundColor: Colors.white,
                  ),

                  child: const Text('Select'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
