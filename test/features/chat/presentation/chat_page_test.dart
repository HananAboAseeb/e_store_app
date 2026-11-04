import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/chat/chat_injection.dart';
import 'package:flutter_clean_architecture_template/features/chat/domain/entities/chat_agent_entity.dart';
import 'package:flutter_clean_architecture_template/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter_clean_architecture_template/features/chat/presentation/widgets/chat_header.dart';
import 'package:flutter_clean_architecture_template/features/chat/presentation/widgets/chat_issue_chip.dart';
import 'package:flutter_clean_architecture_template/features/chat/presentation/widgets/chat_order_card.dart';
import 'package:flutter_clean_architecture_template/features/chat/presentation/widgets/chat_review_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initChatInjection();
  });

  tearDown(() async {
    await sl.reset();
  });

  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          home: child,
        );
      },
    );
  }

  testWidgets(
    'ChatPage renders Screen 68 Bot Triage flow with header, welcome message, chips, and Next button',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const ChatPage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(ChatHeader), findsOneWidget);
      expect(find.text('Chat Bot'), findsOneWidget);
      expect(find.text('Customer Care Service'), findsOneWidget);

      // Verify Screen 68 Triage Question & Chips
      expect(find.text("What's your issue?"), findsOneWidget);
      expect(find.byType(ChatIssueChip), findsNWidgets(5));
      expect(find.text('Order Issues'), findsOneWidget);
      expect(find.text('Item Quality'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    },
  );

  testWidgets(
    'ChatPage navigates through Bot Triage steps: Screen 68 -> Screen 69 -> Screen 70',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const ChatPage()));
      await tester.pumpAndSettle();

      // Tap Next to navigate to Screen 69 (Order Issues)
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Order Issues'), findsWidgets);
      expect(find.text("I didn't receive my order"), findsOneWidget);

      // Tap Next to navigate to Screen 70 (Select your Order)
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Select your Order'), findsOneWidget);
      expect(find.byType(ChatOrderCard), findsWidgets);
    },
  );

  testWidgets(
    'ChatReviewSheet modal renders agent info, 5 stars, comment field, and Send Review CTA',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const testAgent = ChatAgentEntity(
        id: 'agent_maggie',
        name: 'Maggy Lee',
        role: 'Customer Care Service',
        avatarUrl: 'assets/images/profile_picture.png',
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const Scaffold(
            body: ChatReviewSheet(agent: testAgent),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rate our Service'), findsOneWidget);
      expect(find.text('Maggy Lee'), findsOneWidget);
      expect(find.text('Customer Care Service'), findsOneWidget);
      expect(find.byIcon(Icons.star_border_rounded), findsNWidgets(5));
      expect(find.text('Send Review'), findsOneWidget);

      // Tap on 4th star
      await tester.tap(find.byIcon(Icons.star_border_rounded).at(3));
      await tester.pumpAndSettle();

      // Now 4 stars should be filled and 1 outlined
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(4));
      expect(find.byIcon(Icons.star_border_rounded), findsNWidgets(1));
    },
  );
}
