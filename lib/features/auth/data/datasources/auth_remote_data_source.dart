import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_consumer.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<List<UserModel>> fetchUsers();
}

class AuthRemoteDataSourceImpl
    implements AuthRemoteDataSource {
  final ApiConsumer _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<List<UserModel>> fetchUsers() async {
    // TODO: replace ApiEndpoints.products with the correct endpoint
    final response = await _dio.get(ApiEndpoints.products);
    return (response as List)
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
