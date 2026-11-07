import 'package:flutter_test/flutter_test.dart';
import 'package:founder_signal/app.dart';

void main() {
  testWidgets('app opens to the Daily Signal shell', (tester) async {
    await tester.pumpWidget(const FounderSignalApp());

    expect(find.text('Daily Signal'), findsOneWidget);
    expect(find.text('Signal'), findsOneWidget);
    expect(find.text('Reflect'), findsOneWidget);
  });
}
