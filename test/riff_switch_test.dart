import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riff_switch/riff_switch.dart';

void main() {
  testWidgets('Widget test for the riff_switch custom widget', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RiffSwitch(
            value: false,
            onChanged: (value) {},
            type: RiffSwitchType.simple,
          ),
        ),
      ),
    );

    final Finder finder = find.byWidgetPredicate(
          (widget) => widget is RiffSwitch && widget.value == false,
    );

    expect(finder, findsOneWidget);
  });

  testWidgets('Tapping the switch changes its value', (widgetTester) async {
    bool switchValue = false; // Toggle to test for both cases

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return RiffSwitch(
                value: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
                type: RiffSwitchType.simple,
              );
            },
          ),
        ),
      ),
    );

    final Finder switchFinder = find.byType(RiffSwitch);

    // Get the size and position of the switch
    final Rect switchRect = widgetTester.getRect(switchFinder);

    // Calculate the tap position on the right side for true
    final Offset tapPosition = Offset(switchRect.right - 1, switchRect.center.dy);

    // Tap the calculated position
    await widgetTester.tapAt(tapPosition);
    await widgetTester.pumpAndSettle();

    // Verify the switch's value has changed
    expect(switchValue, true); // Toggle to test for both cases
  });


  testWidgets('RiffSwitch has correct initial state', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RiffSwitch(
            value: true,
            onChanged: (value) {},
            type: RiffSwitchType.simple,
          ),
        ),
      ),
    );

    final Finder finder = find.byWidgetPredicate(
          (widget) => widget is RiffSwitch && widget.value == true,
    );

    expect(finder, findsOneWidget);
  });

  testWidgets('RiffSwitch renders correctly', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RiffSwitch(
            value: false,
            onChanged: (value) {},
            type: RiffSwitchType.simple,
          ),
        ),
      ),
    );

    // Verify the widget renders with the correct initial value
    expect(find.byType(RiffSwitch), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is RiffSwitch && widget.value == false), findsOneWidget);
  });

  testWidgets('RiffSwitch onChanged callback is triggered', (widgetTester) async {
    bool wasCalled = false;

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RiffSwitch(
            value: false,
            onChanged: (value) {
              wasCalled = true;
            },
            type: RiffSwitchType.simple,
          ),
        ),
      ),
    );

    final Finder switchFinder = find.byType(RiffSwitch);

    // Tap the switch
    await widgetTester.tap(switchFinder);
    await widgetTester.pumpAndSettle();

    // Verify the callback was triggered
    expect(wasCalled, true);
  });

  testWidgets('RiffSwitch renders correctly for different types', (widgetTester) async {
    for (var type in RiffSwitchType.values) {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RiffSwitch(
              value: false,
              onChanged: (value) {},
              type: type,
            ),
          ),
        ),
      );

      // Verify the widget renders correctly for each type
      expect(find.byType(RiffSwitch), findsOneWidget);
    }
  });
}
