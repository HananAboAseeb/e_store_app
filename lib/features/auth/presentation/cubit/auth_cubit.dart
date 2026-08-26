import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.verifyOtpUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> register(String email, String password, String phoneNumber) async {
    emit(AuthLoading());
    final result = await registerUseCase(
      RegisterParams(email: email, password: password, phoneNumber: phoneNumber),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthOtpSent(email)),
    );
  }

  Future<void> verifyOtp(String email, String otpCode) async {
    emit(AuthLoading());
    final result = await verifyOtpUseCase(
      VerifyOtpParams(email: email, otpCode: otpCode),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthOtpVerified(user)),
    );
  }

  Future<void> forgotPassword(String email, String method) async {
    emit(AuthLoading());
    final result = await forgotPasswordUseCase(
      ForgotPasswordParams(email: email, method: method),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthOtpSent(email)),
    );
  }

  Future<void> resetPassword(String email, String newPassword, String confirmPassword) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase(
      ResetPasswordParams(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthPasswordReset()),
    );
  }

  void resetState() {
    emit(AuthInitial());
  }
}
