import 'package:flutter_test/flutter_test.dart';
import 'package:riff_switch/riff_switch.dart';

void main() {
  testWidgets('Widget test for the riff_switch custom widget', (widgetTester) async {
    await widgetTester.pumpWidget(TextSwitch(value: false, onChanged: (value) {}));

    final Finder finder = find.byWidgetPredicate((widget) => widget is TextSwitch && widget.value == false);

    expect(finder, findsOneWidget);
  });
}
