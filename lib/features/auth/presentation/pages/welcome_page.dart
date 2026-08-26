import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../widgets/page_indicators.dart';
import '../widgets/welcome_background.dart';
import '../widgets/welcome_card.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _ctrl = PageController();
  int _page = 0;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: WelcomeBackground(
          child: Column(
            children: [
              const Spacer(flex: 3),
              SizedBox(
                height: 520.h,
                child: PageView(
                  controller: _ctrl,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: [
                    const WelcomeCard(
                      title: 'Hello',
                      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.',
                    ),
                    WelcomeCard(
                      title: 'Ready?',
                      buttonText: "Let's Start",
                      onButtonPressed: () => context.go('/home'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              PageIndicators(activeIndex: _page == 0 ? 1 : 1),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
