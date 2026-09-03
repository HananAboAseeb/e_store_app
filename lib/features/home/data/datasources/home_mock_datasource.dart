import '../models/home_data_model.dart';

abstract class HomeMockDataSource {
  Future<HomeDataModel> getHomeData();
}
