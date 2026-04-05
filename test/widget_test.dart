import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:neo_cosmos/core/theme/app_theme.dart';
import 'package:neo_cosmos/features/base/presentation/base_screen.dart';

void main() {
  testWidgets('Base screen shows planet overview', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const BaseScreen(),
        ),
      ),
    );

    expect(find.text('Gezegen Alpha'), findsOneWidget);
    expect(find.text('Binalar'), findsOneWidget);
  });
}
