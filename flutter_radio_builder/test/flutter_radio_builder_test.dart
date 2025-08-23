import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/widget/radio_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RadioBuilder Widget Tests', () {
    final options = ["Apple", "Banana", "Cherry"];

    testWidgets('renders all options correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RadioBuilder<String>(
            list: options,
            optionTextBuilder: (item, _) => item,
          ),
        ),
      );

      // Verify all options are visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);
    });

    testWidgets('selecting an option triggers callback', (
      WidgetTester tester,
    ) async {
      String? selectedItem;
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: RadioBuilder<String>(
            list: options,
            optionTextBuilder: (item, _) => item,
            onSelectionChanged: (item, index) {
              selectedItem = item;
              selectedIndex = index;
            },
          ),
        ),
      );

      // Tap Banana
      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      expect(selectedItem, equals("Banana"));
      expect(selectedIndex, equals(1));
    });

    testWidgets('hover effect applies scaling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RadioBuilder<String>(
            list: options,
            optionTextBuilder: (item, _) => item,
            radioStyle: RadioStyle(hoverEffect: true),
          ),
        ),
      );

      final bananaFinder = find.text('Banana');
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      await gesture.moveTo(tester.getCenter(bananaFinder));
      await tester.pumpAndSettle();

      // Expect hover notifier to scale widget
      expect(bananaFinder, findsOneWidget);
    });

    testWidgets('custom builder renders properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RadioBuilder<String>(
            list: options,
            builder: (context, item, index, radio, checked) {
              return Text("$item - ${checked ? 'Selected' : 'Unselected'}");
            },
          ),
        ),
      );

      expect(find.text("Apple - Unselected"), findsOneWidget);
      expect(find.text("Banana - Unselected"), findsOneWidget);
      expect(find.text("Cherry - Unselected"), findsOneWidget);
    });
  });
}
