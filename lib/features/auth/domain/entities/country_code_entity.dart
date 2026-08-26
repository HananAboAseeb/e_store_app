import 'package:equatable/equatable.dart';

class CountryCodeEntity extends Equatable {
  final String countryName;
  final String dialCode;
  final String flagEmoji;

  const CountryCodeEntity({
    required this.countryName,
    required this.dialCode,
    required this.flagEmoji,
  });

  @override
  List<Object?> get props => [countryName, dialCode, flagEmoji];
}
