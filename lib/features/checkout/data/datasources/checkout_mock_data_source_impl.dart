import '../models/checkout_summary_model.dart';
import '../models/contact_info_model.dart';
import '../models/order_item_model.dart';
import '../models/shipping_address_model.dart';
import '../models/shipping_option_model.dart';
import '../models/voucher_model.dart';
import 'checkout_mock_data_source.dart';

class CheckoutMockDataSourceImpl implements CheckoutMockDataSource {
  ShippingAddressModel _shippingAddress = const ShippingAddressModel(
    id: 'addr-1',
    country: 'United States',
    city: 'New York, NY',
    street: '110 W 44th Street',
    zipCode: '10036',
  );

  final ContactInfoModel _contactInfo = const ContactInfoModel(
    id: 'contact-1',
    phone: '+1-866-922-8694',
    email: 'design.blackside@gmail.com',
  );

  final List<OrderItemModel> _items = [
    const OrderItemModel(
      id: 'item-1',
      productId: 'prod-1',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_cloth_1.png',
      quantity: 1,
      size: 'M',
      color: 'Pink',
      unitPrice: 17.00,
    ),
    const OrderItemModel(
      id: 'item-2',
      productId: 'prod-2',
      title: 'Lorem ipsum dolor sit amet consectetur.',
      imageUrl: 'assets/images/cat_cloth_2.png',
      quantity: 1,
      size: 'M',
      color: 'Pink',
      unitPrice: 17.00,
    ),
  ];

  List<ShippingOptionModel> _shippingOptions = [
    const ShippingOptionModel(
      id: 'standard',
      name: 'Standard',
      duration: '5 - 7 Days',
      price: 3.00,
      estimatedDate: 'Delivered on or before Thursday, 23 April 2020',
      isSelected: true,
    ),
    const ShippingOptionModel(
      id: 'express',
      name: 'Express',
      duration: '1 - 2 Days',
      price: 12.00,
      estimatedDate: 'Delivered on or before Tuesday, 21 April 2020',
      isSelected: false,
    ),
  ];

  final List<VoucherModel> _vouchers = [
    const VoucherModel(
      id: 'care-15',
      title: 'From Customer Care',
      description: '15% off your next purchase',
      discountPercentage: 15.0,
      validUntil: '5.16.20',
      code: 'CARE15',
      iconType: 'careRosette',
    ),
    const VoucherModel(
      id: 'first-5',
      title: 'First Purchase',
      description: '5% off for your next order',
      discountPercentage: 5.0,
      validUntil: '6.20.20',
      code: 'FIRST5',
      iconType: 'shoppingBag',
    ),
  ];

  VoucherModel? _appliedVoucher;
  String _selectedPaymentMethod = 'card';

  CheckoutSummaryModel _buildSummary() {
    final selectedOption = _shippingOptions.firstWhere(
      (o) => o.isSelected,
      orElse: () => _shippingOptions.first,
    );

    return CheckoutSummaryModel(
      id: 'checkout-session-1',
      shippingAddress: _shippingAddress,
      contactInfo: _contactInfo,
      items: List.unmodifiable(_items),
      shippingOptions: List.unmodifiable(_shippingOptions),
      selectedShippingOption: selectedOption,
      appliedVoucher: _appliedVoucher,
      selectedPaymentMethod: _selectedPaymentMethod,
    );
  }

  @override
  Future<CheckoutSummaryModel> getCheckoutSummary() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _buildSummary();
  }

  @override
  Future<List<VoucherModel>> getActiveVouchers() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_vouchers);
  }

  @override
  Future<CheckoutSummaryModel> applyVoucher(String voucherId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final match = _vouchers.where((v) => v.id == voucherId);
    if (match.isNotEmpty) {
      _appliedVoucher = match.first;
    }
    return _buildSummary();
  }

  @override
  Future<CheckoutSummaryModel> removeVoucher() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _appliedVoucher = null;
    return _buildSummary();
  }

  @override
  Future<CheckoutSummaryModel> updateShippingOption(String optionId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _shippingOptions = _shippingOptions.map((opt) {
      return opt.copyWith(isSelected: opt.id == optionId);
    }).toList();
    return _buildSummary();
  }

  @override
  Future<CheckoutSummaryModel> updateShippingAddress(
      ShippingAddressModel address) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _shippingAddress = address;
    return _buildSummary();
  }

  @override
  Future<CheckoutSummaryModel> updatePaymentMethod(String method) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _selectedPaymentMethod = method;
    return _buildSummary();
  }
}
