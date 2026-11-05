import 'package:equatable/equatable.dart';

import '../../domain/entities/user_account_entity.dart';

enum AccountStatus {
  initial,
  loading,
  loaded,
  updating,
  updateSuccess,
  failure
}

class AccountState extends Equatable {
  final AccountStatus status;
  final UserAccountEntity? userProfile;
  final bool isEditing;
  final String? errorMessage;

  const AccountState({
    this.status = AccountStatus.initial,
    this.userProfile,
    this.isEditing = false,
    this.errorMessage,
  });

  AccountState copyWith({
    AccountStatus? status,
    UserAccountEntity? userProfile,
    bool? isEditing,
    String? errorMessage,
  }) {
    return AccountState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      isEditing: isEditing ?? this.isEditing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, userProfile, isEditing, errorMessage];
}
