class CountryCode {
  final String flag;
  final String name;
  final String dialCode;

  const CountryCode({
    required this.flag,
    required this.name,
    required this.dialCode,
  });

  static const List<CountryCode> defaultCountries = [
    CountryCode(flag: '🇬🇧', name: 'United Kingdom', dialCode: '+44'),
    CountryCode(flag: '🇺🇸', name: 'United States', dialCode: '+1'),
    CountryCode(flag: '🇸🇦', name: 'Saudi Arabia', dialCode: '+966'),
    CountryCode(flag: '🇪🇬', name: 'Egypt', dialCode: '+20'),
    CountryCode(flag: '🇦🇪', name: 'UAE', dialCode: '+971'),
  ];
}
