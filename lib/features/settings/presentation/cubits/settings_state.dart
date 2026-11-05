import 'package:equatable/equatable.dart';

enum SettingsStatus { initial, loading, loaded, failure, accountDeleted }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final String appVersion;
  final String? errorMessage;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.appVersion = 'Version 1.0 June, 2026',
    this.errorMessage,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    String? appVersion,
    String? errorMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      appVersion: appVersion ?? this.appVersion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, appVersion, errorMessage];
}
