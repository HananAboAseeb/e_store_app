import '../models/flash_sale_data_model.dart';

abstract class FlashSaleMockDataSource {
  Future<FlashSaleDataModel> getFlashSaleData();
}
