import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/max_attempts_error_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/start_page.dart';
import '../../features/auth/presentation/pages/verification_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../root.dart';
import 'route_names.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.kStartPage,
  routes: [
    // ── Auth Routes ─────────────────────────────────────────────────────────────
    GoRoute(
      path: RouteNames.kStartPage,
      name: 'start',
      builder: (context, state) => const StartPage(),
    ),
    GoRoute(
      path: RouteNames.kLoginPage,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteNames.kRegisterPage,
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: RouteNames.kVerificationPage,
      name: 'verification',
      builder: (context, state) {
        final extra = state.extra;
        String email = '';
        VerificationMode mode = VerificationMode.register;
        String? phoneNumber;

        if (extra is Map<String, dynamic>) {
          email = (extra['email'] as String?) ?? '';
          mode = (extra['mode'] as VerificationMode?) ?? VerificationMode.register;
          phoneNumber = extra['phoneNumber'] as String?;
        } else if (extra is String) {
          email = extra;
        }

        final modeQuery = state.uri.queryParameters['mode'];
        if (modeQuery == 'recovery') {
          mode = VerificationMode.passwordRecovery;
        }

        return VerificationPage(
          email: email,
          mode: mode,
          phoneNumber: phoneNumber,
        );
      },
    ),
    GoRoute(
      path: RouteNames.kForgotPasswordPage,
      name: 'forgot-password',
      builder: (context, state) {
        final email = (state.extra as String?) ?? '';
        return ForgotPasswordPage(email: email);
      },
    ),
    GoRoute(
      path: RouteNames.kResetPasswordPage,
      name: 'reset-password',
      builder: (context, state) {
        final email = (state.extra as String?) ?? '';
        return ResetPasswordPage(email: email);
      },
    ),
    GoRoute(
      path: RouteNames.kWelcomePage,
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: RouteNames.kMaxAttemptsErrorPage,
      name: 'max-attempts-error',
      builder: (context, state) => const MaxAttemptsErrorPage(),
    ),

    // ── Main App Shell Routes ──────────────────────────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.kHomePage,
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.kCartPage,
              name: 'cart',
              builder: (context, state) => const CartPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.kProfilePage,
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
