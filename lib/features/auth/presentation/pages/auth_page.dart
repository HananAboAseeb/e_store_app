import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../manager/user/user_cubit.dart';
import '../manager/user/user_state.dart';
import '../widgets/auth_widgets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserCubit>()..loadData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Auth'),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserError) {
              return Center(child: Text(state.message));
            }
            if (state is UserLoaded) {
              return AuthList(items: state.items);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
