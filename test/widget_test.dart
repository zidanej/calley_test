import 'package:flutter_test/flutter_test.dart';

import 'package:calley_app/main.dart';

void main() {
  testWidgets('App launches on language selection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalleyApp());

    expect(find.text('Choose Your Language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
  });
}
