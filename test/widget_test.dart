import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:csen280_hw4/bloc/authentication_bloc.dart';
import 'package:csen280_hw4/main.dart';

void main() {
  testWidgets('Login, browse books, logout flow', (tester) async {
    await tester.pumpWidget(
      BlocProvider(create: (_) => AuthenticationBloc(), child: const MyApp()),
    );
    await tester.pumpAndSettle();

    // Not logged in -> /login
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);

    // Login -> /byAuthor
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('Sorted by Author'), findsOneWidget);

    // Book -> /byAuthor/detail, then back
    await tester.tap(find.text('Da Vinci Code').first);
    await tester.pumpAndSettle();
    expect(find.text('Detail of the Book'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Sorted by Author'), findsOneWidget);

    // By Title tab -> /byTitle/detail
    await tester.tap(find.text('By Title'));
    await tester.pumpAndSettle();
    expect(find.text('Sorted by Title'), findsOneWidget);
    await tester.tap(find.text('Da Vinci Code').first);
    await tester.pumpAndSettle();
    expect(find.text('Detail of the Book'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Profile -> Logout -> /login
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Logout'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Login'), findsOneWidget);
  });
}
