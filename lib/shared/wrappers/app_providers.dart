import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection_container.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/theme/presentation/manager/theme_cubit.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeCubit>()..loadData()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
      ],
      child: child,
    );
  }
}
