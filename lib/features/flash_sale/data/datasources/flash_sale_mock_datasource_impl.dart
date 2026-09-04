import '../models/flash_sale_data_model.dart';
import '../models/flash_sale_product_model.dart';
import '../models/live_stream_model.dart';
import 'flash_sale_mock_datasource.dart';

class FlashSaleMockDataSourceImpl implements FlashSaleMockDataSource {
  @override
  Future<FlashSaleDataModel> getFlashSaleData() async {
    // Simulate 1.2s realistic network latency
    await Future.delayed(const Duration(milliseconds: 1200));

    return const FlashSaleDataModel(
      countdownDuration: Duration(hours: 0, minutes: 36, seconds: 58),
      liveStream: LiveStreamModel(
        id: 'live_stream_01',
        title: 'ARTICALE REIMAGINED',
        bannerUrl: 'assets/images/girl_image.png',
        isLive: true,
        viewerCount: 1780,
      ),
      products: [
        // 20% Discount Products (Figma primary display)
        FlashSaleProductModel(
          id: 'flash_20_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 16.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 20,
          likeCount: 1780,
          tag: 'Sale',
        ),
        FlashSaleProductModel(
          id: 'flash_20_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 16.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 20,
          likeCount: 1420,
          tag: 'Sale',
        ),
        FlashSaleProductModel(
          id: 'flash_20_3',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 16.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 20,
          likeCount: 950,
          tag: 'Hot',
        ),
        FlashSaleProductModel(
          id: 'flash_20_4',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 16.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 20,
          likeCount: 1200,
          tag: 'New',
        ),

        // 10% Discount Products
        FlashSaleProductModel(
          id: 'flash_10_1',
          title: 'Casual Cotton Basic T-Shirt Slim Fit',
          currentPrice: 18.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 10,
          likeCount: 880,
          tag: 'New',
        ),
        FlashSaleProductModel(
          id: 'flash_10_2',
          title: 'Classic Vintage Cap Canvas Edition',
          currentPrice: 27.00,
          originalPrice: 30.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 10,
          likeCount: 650,
          tag: 'Sale',
        ),

        // 30% Discount Products
        FlashSaleProductModel(
          id: 'flash_30_1',
          title: 'Modern Streetwear Hooded Zip Jacket',
          currentPrice: 35.00,
          originalPrice: 50.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 30,
          likeCount: 2100,
          tag: 'Hot',
        ),
        FlashSaleProductModel(
          id: 'flash_30_2',
          title: 'Relaxed Fit Graphic Pullover Hoodie',
          currentPrice: 42.00,
          originalPrice: 60.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 30,
          likeCount: 1340,
          tag: 'Sale',
        ),

        // 40% Discount Products
        FlashSaleProductModel(
          id: 'flash_40_1',
          title: 'Urban Explorer Lightweight Utility Parka',
          currentPrice: 48.00,
          originalPrice: 80.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 40,
          likeCount: 1890,
          tag: 'Hot',
        ),
        FlashSaleProductModel(
          id: 'flash_40_2',
          title: 'Monochrome Knitted Wool Winter Sweater',
          currentPrice: 36.00,
          originalPrice: 60.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 40,
          likeCount: 1110,
          tag: 'Sale',
        ),

        // 50% Discount Products
        FlashSaleProductModel(
          id: 'flash_50_1',
          title: 'Premium Denim Trucker Outer Jacket',
          currentPrice: 50.00,
          originalPrice: 100.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 50,
          likeCount: 3100,
          tag: 'Hot',
        ),
        FlashSaleProductModel(
          id: 'flash_50_2',
          title: 'Seasonal Corduroy Oversized Overshirt',
          currentPrice: 45.00,
          originalPrice: 90.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 50,
          likeCount: 2540,
          tag: 'Sale',
        ),
      ],
      popularProducts: [
        FlashSaleProductModel(
          id: 'pop_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 17.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 15,
          likeCount: 1780,
          tag: 'New',
        ),
        FlashSaleProductModel(
          id: 'pop_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 17.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 15,
          likeCount: 1780,
          tag: 'Sale',
        ),
        FlashSaleProductModel(
          id: 'pop_3',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 17.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/jact.png',
          discountPercentage: 15,
          likeCount: 1780,
          tag: 'Hot',
        ),
        FlashSaleProductModel(
          id: 'pop_4',
          title: 'Lorem ipsum dolor sit amet consectetur',
          currentPrice: 17.00,
          originalPrice: 20.00,
          imageUrl: 'assets/images/image1.png',
          discountPercentage: 15,
          likeCount: 1780,
          tag: 'Sale',
        ),
      ],
    );
  }
}
