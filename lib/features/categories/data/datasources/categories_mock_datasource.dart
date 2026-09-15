import '../../domain/entities/gender_filter.dart';
import '../models/category_group_model.dart';

abstract class CategoriesMockDataSource {
  Future<List<CategoryGroupModel>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });
}
