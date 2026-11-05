import '../../domain/entities/payment_card_entity.dart';
import '../models/country_model.dart';
import '../models/currency_model.dart';
import '../models/language_model.dart';
import '../models/payment_card_model.dart';
import '../models/payment_history_model.dart';
import '../models/shipping_address_model.dart';
import '../models/size_standard_model.dart';
import '../models/user_account_model.dart';
import 'settings_mock_data_source.dart';

class SettingsMockDataSourceImpl implements SettingsMockDataSource {
  UserAccountModel _profile = const UserAccountModel(
    id: 'usr_001',
    username: 'Romina',
    email: 'gmail@example.com',
    passwordMasked: '***************',
    avatarUrl: 'assets/images/profile_picture.png',
  );

  final List<PaymentCardModel> _cards = [
    const PaymentCardModel(
      id: 'card_mc_01',
      cardBrand: CardType.mastercard,
      cardholderName: 'AMANDA',
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      expirationDate: '12/22',
      cvv: '676',
      isDefault: true,
    ),
    const PaymentCardModel(
      id: 'card_visa_02',
      cardBrand: CardType.visa,
      cardholderName: 'AMANDA',
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      expirationDate: '12/22',
      cvv: '123',
      isDefault: false,
    ),
  ];

  final List<PaymentHistoryModel> _history = const [
    PaymentHistoryModel(
      id: 'tx_01',
      orderNumber: 'Order #92287157',
      transactionDate: 'April,19 2020 12:31',
      amount: 14.00,
      isDebit: false,
    ),
    PaymentHistoryModel(
      id: 'tx_02',
      orderNumber: 'Order #92287157',
      transactionDate: 'April,19 2020 12:31',
      amount: 21.00,
      isDebit: false,
    ),
    PaymentHistoryModel(
      id: 'tx_03',
      orderNumber: 'Order #92287157',
      transactionDate: 'April,19 2020 12:31',
      amount: 37.00,
      isDebit: true,
    ),
    PaymentHistoryModel(
      id: 'tx_04',
      orderNumber: 'Order #92287157',
      transactionDate: 'April,19 2020 12:31',
      amount: 14.00,
      isDebit: false,
    ),
  ];

  ShippingAddressModel _shippingAddress = const ShippingAddressModel(
    id: 'addr_01',
    country: 'Iran',
    addressLine: '110 W 44th Street, NY 10036',
    city: 'New York',
    postcode: '10012',
    phoneNumber: '+98*******22',
  );

  List<CountryModel> _countries = [
    const CountryModel(
        id: 'c_ye', name: 'Yemen (اليمن)', code: 'YE', isSelected: true),
    const CountryModel(id: 'c_sa', name: 'Saudi Arabia (السعودية)', code: 'SA'),
    const CountryModel(
        id: 'c_ae', name: 'United Arab Emirates (الإمارات)', code: 'AE'),
    const CountryModel(id: 'c_eg', name: 'Egypt (مصر)', code: 'EG'),
    const CountryModel(id: 'c_kw', name: 'Kuwait (الكويت)', code: 'KW'),
    const CountryModel(id: 'c_qa', name: 'Qatar (قطر)', code: 'QA'),
    const CountryModel(id: 'c_bh', name: 'Bahrain (البحرين)', code: 'BH'),
    const CountryModel(id: 'c_om', name: 'Oman (عُمان)', code: 'OM'),
    const CountryModel(id: 'c_jo', name: 'Jordan (الأردن)', code: 'JO'),
    const CountryModel(id: 'c_lb', name: 'Lebanon (لبنان)', code: 'LB'),
    const CountryModel(id: 'c_iq', name: 'Iraq (العراق)', code: 'IQ'),
    const CountryModel(id: 'c_ps', name: 'Palestine (فلسطين)', code: 'PS'),
    const CountryModel(id: 'c_sy', name: 'Syria (سوريا)', code: 'SY'),
    const CountryModel(id: 'c_ma', name: 'Morocco (المغرب)', code: 'MA'),
    const CountryModel(id: 'c_dz', name: 'Algeria (الجزائر)', code: 'DZ'),
    const CountryModel(id: 'c_tn', name: 'Tunisia (تونس)', code: 'TN'),
    const CountryModel(id: 'c_ly', name: 'Libya (ليبيا)', code: 'LY'),
    const CountryModel(id: 'c_sd', name: 'Sudan (السودان)', code: 'SD'),
    const CountryModel(id: 'c_so', name: 'Somalia (الصومال)', code: 'SO'),
    const CountryModel(id: 'c_dj', name: 'Djibouti (جيبوتي)', code: 'DJ'),
    const CountryModel(id: 'c_mr', name: 'Mauritania (موريتانيا)', code: 'MR'),
    const CountryModel(id: 'c_km', name: 'Comoros (جزر القمر)', code: 'KM'),
    const CountryModel(id: 'c_af', name: 'Afghanistan', code: 'AF'),
    const CountryModel(id: 'c_al', name: 'Albania', code: 'AL'),
    const CountryModel(id: 'c_ad', name: 'Andorra', code: 'AD'),
    const CountryModel(id: 'c_ao', name: 'Angola', code: 'AO'),
    const CountryModel(id: 'c_ag', name: 'Antigua and Barbuda', code: 'AG'),
    const CountryModel(id: 'c_ar', name: 'Argentina', code: 'AR'),
    const CountryModel(id: 'c_am', name: 'Armenia', code: 'AM'),
    const CountryModel(id: 'c_aw', name: 'Aruba', code: 'AW'),
    const CountryModel(id: 'c_au', name: 'Australia', code: 'AU'),
    const CountryModel(id: 'c_at', name: 'Austria', code: 'AT'),
    const CountryModel(id: 'c_az', name: 'Azerbaijan', code: 'AZ'),
    const CountryModel(id: 'c_bs', name: 'Bahamas', code: 'BS'),
    const CountryModel(id: 'c_bd', name: 'Bangladesh', code: 'BD'),
    const CountryModel(id: 'c_bb', name: 'Barbados', code: 'BB'),
    const CountryModel(id: 'c_by', name: 'Belarus', code: 'BY'),
    const CountryModel(id: 'c_be', name: 'Belgium', code: 'BE'),
    const CountryModel(id: 'c_bz', name: 'Belize', code: 'BZ'),
    const CountryModel(id: 'c_bj', name: 'Benin', code: 'BJ'),
    const CountryModel(id: 'c_bt', name: 'Bhutan', code: 'BT'),
    const CountryModel(id: 'c_bo', name: 'Bolivia', code: 'BO'),
    const CountryModel(id: 'c_ba', name: 'Bosnia and Herzegovina', code: 'BA'),
    const CountryModel(id: 'c_bw', name: 'Botswana', code: 'BW'),
    const CountryModel(id: 'c_br', name: 'Brazil', code: 'BR'),
    const CountryModel(id: 'c_bn', name: 'Brunei', code: 'BN'),
    const CountryModel(id: 'c_bg', name: 'Bulgaria', code: 'BG'),
    const CountryModel(id: 'c_bf', name: 'Burkina Faso', code: 'BF'),
    const CountryModel(id: 'c_bi', name: 'Burundi', code: 'BI'),
    const CountryModel(id: 'c_kh', name: 'Cambodia', code: 'KH'),
    const CountryModel(id: 'c_cm', name: 'Cameroon', code: 'CM'),
    const CountryModel(id: 'c_ca', name: 'Canada', code: 'CA'),
    const CountryModel(id: 'c_ir', name: 'Iran', code: 'IR'),
  ];

  List<LanguageModel> _languages = [
    const LanguageModel(
      id: 'lang_ar',
      name: 'Arabic',
      nativeName: 'العربية',
      localeCode: 'ar',
      isSelected: false,
    ),
    const LanguageModel(
      id: 'lang_en',
      name: 'English',
      nativeName: 'English',
      localeCode: 'en',
      isSelected: true,
    ),
    const LanguageModel(
      id: 'lang_fr',
      name: 'Français',
      nativeName: 'Français',
      localeCode: 'fr',
      isSelected: false,
    ),
    const LanguageModel(
      id: 'lang_zh',
      name: '中文',
      nativeName: '中文',
      localeCode: 'zh',
      isSelected: false,
    ),
    const LanguageModel(
      id: 'lang_es',
      name: 'Español',
      nativeName: 'Español',
      localeCode: 'es',
      isSelected: false,
    ),
    const LanguageModel(
      id: 'lang_ru',
      name: 'Русский',
      nativeName: 'Русский',
      localeCode: 'ru',
      isSelected: false,
    ),
    const LanguageModel(
      id: 'lang_fa',
      name: 'فارسی',
      nativeName: 'فارسی',
      localeCode: 'fa',
      isSelected: false,
    ),
  ];

  List<CurrencyModel> _currencies = [
    const CurrencyModel(
      id: 'curr_usd',
      code: 'USD',
      symbol: '\$',
      label: '\$ USD',
      isSelected: true,
    ),
    const CurrencyModel(
      id: 'curr_eur',
      code: 'EUR',
      symbol: '€',
      label: '€ EURO',
      isSelected: false,
    ),
  ];

  List<SizeStandardModel> _sizes = [
    const SizeStandardModel(
      id: 'size_us',
      label: 'US',
      isSelected: true,
    ),
    const SizeStandardModel(
      id: 'size_eu',
      label: 'EU',
      isSelected: false,
    ),
    const SizeStandardModel(
      id: 'size_uk',
      label: 'UK',
      isSelected: false,
    ),
  ];

  @override
  Future<UserAccountModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _profile;
  }

  @override
  Future<UserAccountModel> updateProfile(UserAccountModel profile) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _profile = profile;
    return _profile;
  }

  @override
  Future<List<PaymentCardModel>> getPaymentCards() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_cards);
  }

  @override
  Future<PaymentCardModel> addPaymentCard(PaymentCardModel card) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cards.add(card);
    return card;
  }

  @override
  Future<PaymentCardModel> updatePaymentCard(PaymentCardModel card) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _cards.indexWhere((c) => c.id == card.id);
    if (index != -1) {
      _cards[index] = card;
    }
    return card;
  }

  @override
  Future<List<PaymentHistoryModel>> getPaymentHistory() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_history);
  }

  @override
  Future<ShippingAddressModel> getShippingAddress() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _shippingAddress;
  }

  @override
  Future<ShippingAddressModel> updateShippingAddress(
    ShippingAddressModel address,
  ) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _shippingAddress = address;
    return _shippingAddress;
  }

  @override
  Future<List<CountryModel>> getCountries() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_countries);
  }

  @override
  Future<List<LanguageModel>> getLanguages() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_languages);
  }

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_currencies);
  }

  @override
  Future<List<SizeStandardModel>> getSizes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_sizes);
  }

  @override
  Future<void> updatePreference(String type, String value) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final lowerVal = value.trim().toLowerCase();
    if (type == 'country') {
      _countries = _countries.map((c) {
        final matches = c.name.toLowerCase().contains(lowerVal) ||
            c.code.toLowerCase() == lowerVal ||
            lowerVal.contains(c.code.toLowerCase());
        return c.copyWith(isSelected: matches);
      }).toList();
    } else if (type == 'language') {
      _languages = _languages.map((l) {
        final matches = l.localeCode.toLowerCase() == lowerVal ||
            l.name.toLowerCase() == lowerVal ||
            l.nativeName.toLowerCase() == lowerVal;
        return l.copyWith(isSelected: matches);
      }).toList();
    } else if (type == 'currency') {
      _currencies = _currencies.map((curr) {
        final matches = curr.code.toLowerCase() == lowerVal ||
            curr.label.toLowerCase() == lowerVal;
        return curr.copyWith(isSelected: matches);
      }).toList();
    } else if (type == 'size') {
      _sizes = _sizes.map((s) {
        final matches = s.label.toLowerCase() == lowerVal;
        return s.copyWith(isSelected: matches);
      }).toList();
    }
  }

  @override
  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
