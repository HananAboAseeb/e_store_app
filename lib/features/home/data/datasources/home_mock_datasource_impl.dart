import '../models/home_data_model.dart';
import 'home_mock_datasource.dart';

class HomeMockDataSourceImpl implements HomeMockDataSource {
  @override
  Future<HomeDataModel> getHomeData() async {
    // Simulate 1.2s realistic network latency
    await Future.delayed(const Duration(milliseconds: 1200));

    return const HomeDataModel(
      banners: [
        HomeBannerModel(
          id: 'banner_1',
          title: 'Big Sale',
          subtitle: 'Up to 50%',
          imageUrl: 'assets/images/girl_image.png',
          discountPercentage: 50,
        ),
        HomeBannerModel(
          id: 'banner_2',
          title: 'Summer Deals',
          subtitle: 'Up to 70%',
          imageUrl: 'assets/images/girl_image.png',
          discountPercentage: 70,
        ),
        HomeBannerModel(
          id: 'banner_3',
          title: 'New Season',
          subtitle: 'Special Edition',
          imageUrl: 'assets/images/girl_image.png',
          discountPercentage: 30,
        ),
      ],
      categories: [
        CategoryModel(
          id: 'cat_clothings',
          name: 'Clothings',
          itemCount: 109,
          previewImageUrls: [
            'assets/images/cat_cloth_1.png',
            'assets/images/cat_cloth_2.png',
          ],
        ),
        CategoryModel(
          id: 'cat_shoes',
          name: 'Shoes',
          itemCount: 530,
          previewImageUrls: [
            'assets/images/cat_shoe_1.png',
            'assets/images/cat_shoe_2.png',
          ],
        ),
        CategoryModel(
          id: 'cat_bags',
          name: 'Bags',
          itemCount: 87,
          previewImageUrls: [
            'assets/images/cat_bag_1.png',
            'assets/images/cat_bag_2.png',
          ],
        ),
        CategoryModel(
          id: 'cat_hoodies',
          name: 'Hoodies',
          itemCount: 123,
          previewImageUrls: [
            'assets/images/cat_hoodie_1.png',
            'assets/images/cat_hoodie_2.png',
          ],
        ),
        CategoryModel(
          id: 'cat_watch',
          name: 'Watch',
          itemCount: 239,
          previewImageUrls: [
            'assets/images/cat_watch_1.png',
            'assets/images/cat_watch_2.png',
          ],
        ),
      ],
      topProducts: [
        HomeProductModel(
          id: 'top_1',
          title: 'Classic Pants',
          price: 25.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'top_2',
          title: 'Summer Outfit',
          price: 35.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'top_3',
          title: 'Formal Shirt',
          price: 45.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'top_4',
          title: 'Sportswear Set',
          price: 30.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'top_5',
          title: 'Casual Hoodie',
          price: 40.0,
          imageUrl: 'assets/images/jact.png',
        ),
      ],
      newItems: [
        HomeProductModel(
          id: 'new_1',
          title: 'Lorem ipsum dolor sit amet consectetur.',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
          tag: 'New',
        ),
        HomeProductModel(
          id: 'new_2',
          title: 'Lorem ipsum dolor sit amet consectetur.',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
          tag: 'New',
        ),
        HomeProductModel(
          id: 'new_3',
          title: 'Lorem ipsum dolor sit amet consectetur.',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
          tag: 'New',
        ),
      ],
      flashSaleProducts: [
        HomeProductModel(
          id: 'flash_1',
          title: 'Wide Leg Pants',
          price: 24.0,
          imageUrl: 'assets/images/home_flash_1.png',
          discountPercentage: 20,
        ),
        HomeProductModel(
          id: 'flash_2',
          title: 'Denim Culottes',
          price: 32.0,
          imageUrl: 'assets/images/home_flash_2.png',
          discountPercentage: 20,
        ),
        HomeProductModel(
          id: 'flash_3',
          title: 'Sleeveless Top',
          price: 18.0,
          imageUrl: 'assets/images/home_flash_3.png',
          discountPercentage: 20,
        ),
        HomeProductModel(
          id: 'flash_4',
          title: 'Floral Summer Dress',
          price: 45.0,
          imageUrl: 'assets/images/home_flash_4.png',
          discountPercentage: 20,
        ),
        HomeProductModel(
          id: 'flash_5',
          title: 'Black Tank Top',
          price: 15.0,
          imageUrl: 'assets/images/home_flash_5.png',
          discountPercentage: 20,
        ),
        HomeProductModel(
          id: 'flash_6',
          title: 'Striped Blue Blouse',
          price: 28.0,
          imageUrl: 'assets/images/home_flash_6.png',
          discountPercentage: 20,
        ),
      ],
      popularProducts: [
        HomeProductModel(
          id: 'pop_1',
          title: 'Bear Hoodie',
          price: 55.0,
          imageUrl: 'assets/images/jact.png',
          likeCount: 1780,
          tag: 'New',
        ),
        HomeProductModel(
          id: 'pop_2',
          title: 'Fur Jacket',
          price: 85.0,
          imageUrl: 'assets/images/jact.png',
          likeCount: 1780,
          tag: 'Sale',
        ),
        HomeProductModel(
          id: 'pop_3',
          title: 'Panda Coat',
          price: 65.0,
          imageUrl: 'assets/images/jact.png',
          likeCount: 1780,
          tag: 'Hot',
        ),
      ],
      stuffForYouProducts: [
        HomeProductModel(
          id: 'stuff_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'stuff_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'stuff_3',
          title: 'Lorem ipsum dolor sit amet consectetur',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'stuff_4',
          title: 'Lorem ipsum dolor sit amet consectetur',
          price: 17.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'stuff_5',
          title: 'Classic Baseball Cap',
          price: 12.0,
          imageUrl: 'assets/images/jact.png',
        ),
        HomeProductModel(
          id: 'stuff_6',
          title: 'Hooded Winter Jacket',
          price: 90.0,
          imageUrl: 'assets/images/jact.png',
        ),
      ],
    );
  }
}
