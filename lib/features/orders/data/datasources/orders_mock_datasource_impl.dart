import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';
import 'orders_mock_datasource.dart';

class OrdersMockDataSourceImpl implements OrdersMockDataSource {
  final List<OrderModel> _orders = [
    // ── Screen 57 Orders (Matching Figma 57 TO RECIEVCE 100%) ────────────────
    // Order 1: 3 items, Packed, Track
    OrderModel(
      id: 'order-1',
      orderNumber: 'Order #92287157',
      items: const [
        OrderItemModel(
          id: 'item-1',
          orderId: 'order-1',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-2',
          orderId: 'order-1',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-3',
          orderId: 'order-1',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 3,
      status: OrderStatus.packed,
      trackingNumber: 'LGS-i92927839300763731',
      createdAt: DateTime(2026, 4, 19, 12, 31),
    ),

    // Order 2: 4 items, Shipped, Track
    OrderModel(
      id: 'order-2',
      orderNumber: 'Order #92287157',
      items: const [
        OrderItemModel(
          id: 'item-2-1',
          orderId: 'order-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-2-2',
          orderId: 'order-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-2-3',
          orderId: 'order-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-2-4',
          orderId: 'order-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 4,
      status: OrderStatus.shipped,
      trackingNumber: 'LGS-92287157',
      createdAt: DateTime(2026, 4, 18, 9, 15),
    ),

    // Order 3 (del-1): 2 items, Delivered, Review
    OrderModel(
      id: 'order-del-1',
      orderNumber: 'Order #92287157',
      items: const [
        OrderItemModel(
          id: 'item-3-1',
          orderId: 'order-del-1',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-3-2',
          orderId: 'order-del-1',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 2,
      status: OrderStatus.delivered,
      trackingNumber: 'LGS-92287157',
      createdAt: DateTime(2026, 4, 15, 8, 0),
      deliveredAt: DateTime(2026, 4, 21, 9, 34),
    ),

    // Order 4 (del-2): 5 items, Delivered, Review
    OrderModel(
      id: 'order-del-2',
      orderNumber: 'Order #92287157',
      items: const [
        OrderItemModel(
          id: 'item-4-1',
          orderId: 'order-del-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-4-2',
          orderId: 'order-del-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-4-3',
          orderId: 'order-del-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-4-4',
          orderId: 'order-del-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-4-5',
          orderId: 'order-del-2',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 5,
      status: OrderStatus.delivered,
      trackingNumber: 'LGS-92287157',
      createdAt: DateTime(2026, 4, 12, 10, 0),
      deliveredAt: DateTime(2026, 4, 18, 14, 0),
    ),

    // Order 5 (del-3): 1 item, Delivered, Review
    OrderModel(
      id: 'order-del-3',
      orderNumber: 'Order #92287157',
      items: const [
        OrderItemModel(
          id: 'item-5-1',
          orderId: 'order-del-3',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 1,
      status: OrderStatus.delivered,
      trackingNumber: 'LGS-92287157',
      createdAt: DateTime(2026, 4, 1, 10, 0),
      deliveredAt: DateTime(2026, 4, 6, 14, 30),
    ),

    // ── Additional Orders for Tracking Tests & Sub-flows ────────────────────
    // Failed Delivery Attempt (Screen 60, 61)
    OrderModel(
      id: 'order-3',
      orderNumber: 'Order #92287157',
      items: const [
        OrderItemModel(
          id: 'item-failed-1',
          orderId: 'order-3',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-failed-2',
          orderId: 'order-3',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
        OrderItemModel(
          id: 'item-failed-3',
          orderId: 'order-3',
          productId: 'prod-1',
          title: 'Light Blue Oversized T-Shirt',
          description: 'Standard delivery package with casual cotton tee.',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 29.99,
          formattedDate: 'April, 06',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 3,
      status: OrderStatus.failedAttempt,
      trackingNumber: 'LGS-i92927839300763731',
      createdAt: DateTime(2026, 4, 17, 14, 20),
    ),

    // To Pay Order
    OrderModel(
      id: 'order-5',
      orderNumber: 'Order #50192837',
      items: const [
        OrderItemModel(
          id: 'item-pay-1',
          orderId: 'order-5',
          productId: 'prod-10',
          title: 'Casual knit sweater pullover.',
          description: 'Soft thermal textured autumn pullover.',
          imageUrl: 'assets/images/cat_cloth_1.png',
          price: 62.00,
          formattedDate: 'April, 20',
        ),
      ],
      deliveryType: 'Standard Delivery',
      itemCount: 1,
      status: OrderStatus.toPay,
      trackingNumber: null,
      createdAt: DateTime(2026, 4, 20, 11, 45),
    ),
  ];

  final List<OrderReviewModel> _reviews = [];

  @override
  Future<List<OrderModel>> getOrders(OrderTab tab) async {
    await Future.delayed(const Duration(milliseconds: 300));
    switch (tab) {
      case OrderTab.toPay:
        return _orders.where((o) => o.status == OrderStatus.toPay).toList();
      case OrderTab.toReceive:
        // Screen 57 Figma displays orders, including in-progress, failed attempt, and delivered
        return [
          _orders.firstWhere((o) => o.id == 'order-1'),
          _orders.firstWhere((o) => o.id == 'order-2'),
          _orders.firstWhere((o) => o.id == 'order-3'),
          _orders.firstWhere((o) => o.id == 'order-del-1'),
          _orders.firstWhere((o) => o.id == 'order-del-2'),
          _orders.firstWhere((o) => o.id == 'order-del-3'),
          _orders.firstWhere((o) => o.id == 'order-5'),
        ];
      case OrderTab.toReview:
        return _orders.where((o) => o.status == OrderStatus.delivered).toList();
    }
  }

  @override
  Future<List<OrderModel>> getOrderHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders.where((o) => o.status == OrderStatus.delivered).toList();
  }

  @override
  Future<OrderModel> getOrderTracking(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final order = _orders.firstWhere(
      (o) => o.id == orderId || o.orderNumber.contains(orderId),
      orElse: () => _orders.first,
    );
    return order;
  }

  @override
  Future<List<TrackingStepModel>> getTrackingSteps(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final order = await getOrderTracking(orderId);

    if (order.status == OrderStatus.failedAttempt) {
      // Screen 60 (Delivery Failed - 6 steps matching Figma exactly)
      return const [
        TrackingStepModel(
          id: 'step-1',
          title: 'Packed',
          timestamp: 'April,19 12:31',
          isCompleted: true,
          iconType: 'package',
        ),
        TrackingStepModel(
          id: 'step-2',
          title: 'On the Way to Logistic Facility',
          timestamp: 'April,19 16:20',
          isCompleted: true,
          iconType: 'transit',
        ),
        TrackingStepModel(
          id: 'step-3',
          title: 'Arrived at Logistic Facility',
          timestamp: 'April,19 19:07',
          isCompleted: true,
          iconType: 'facility',
        ),
        TrackingStepModel(
          id: 'step-4',
          title: 'shipped',
          timestamp: 'April,20 06:15',
          isCompleted: true,
          iconType: 'shipped',
        ),
        TrackingStepModel(
          id: 'step-5',
          title: 'Delivered',
          timestamp: null,
          isCompleted: false,
          iconType: 'delivered_orange',
        ),
        TrackingStepModel(
          id: 'step-6',
          title: 'Attempt to deliver your parcel was not successful',
          timestamp: null,
          isCompleted: false,
          isFailed: true,
          iconType: 'alert',
        ),
      ];
    } else if (order.status == OrderStatus.delivered) {
      // Screen 63 (Delivered - all 5 blue matching Figma exactly)
      return const [
        TrackingStepModel(
          id: 'step-1',
          title: 'Packed',
          timestamp: 'April,19 12:31',
          isCompleted: true,
          iconType: 'package',
        ),
        TrackingStepModel(
          id: 'step-2',
          title: 'On the Way to Logistic Facility',
          timestamp: 'April,19 16:20',
          isCompleted: true,
          iconType: 'transit',
        ),
        TrackingStepModel(
          id: 'step-3',
          title: 'Arrived at Logistic Facility',
          timestamp: 'April,19 19:07',
          isCompleted: true,
          iconType: 'facility',
        ),
        TrackingStepModel(
          id: 'step-4',
          title: 'shipped',
          timestamp: 'April,20 06:15',
          isCompleted: true,
          iconType: 'shipped',
        ),
        TrackingStepModel(
          id: 'step-5',
          title: 'delivered',
          timestamp: 'April,21 09:24',
          isCompleted: true,
          iconType: 'delivered',
        ),
      ];
    } else {
      // Screen 59 (In Progress - steps 1, 2 completed, 3, 4, 5 pending)
      return const [
        TrackingStepModel(
          id: 'step-1',
          title: 'Packed',
          timestamp: 'April,19 12:31',
          isCompleted: true,
          iconType: 'package',
        ),
        TrackingStepModel(
          id: 'step-2',
          title: 'On the Way to Logistic Facility',
          timestamp: 'April,19 16:20',
          isCompleted: true,
          iconType: 'transit',
        ),
        TrackingStepModel(
          id: 'step-3',
          title: 'Arrived at Logistic Facility',
          timestamp: 'April,19 19:07',
          isCompleted: false,
          iconType: 'facility',
        ),
        TrackingStepModel(
          id: 'step-4',
          title: 'shipped',
          timestamp: 'Expected on April,20',
          isCompleted: false,
          iconType: 'shipped',
        ),
        TrackingStepModel(
          id: 'step-5',
          title: 'Delivered',
          timestamp: null,
          isCompleted: false,
          iconType: 'delivered',
        ),
      ];
    }
  }

  @override
  Future<List<OrderItemModel>> getItemsToReview(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final order = await getOrderTracking(orderId);
    final cleanOrderNumber = order.orderNumber.replaceAll('Order #', '');
    return [
      OrderItemModel(
        id: '$orderId-review-1',
        orderId: cleanOrderNumber,
        productId: 'prod-cloth-1',
        title: 'Lorem ipsum dolor sit amet consectetur.',
        description: 'Standard delivery package with casual cotton wear.',
        imageUrl: 'assets/images/cat_cloth_1.png',
        price: 49.99,
        formattedDate: 'April, 06',
      ),
      OrderItemModel(
        id: '$orderId-review-2',
        orderId: cleanOrderNumber,
        productId: 'prod-cloth-2',
        title: 'Lorem ipsum dolor sit amet consectetur.',
        description: 'Standard delivery package with casual cotton wear.',
        imageUrl: 'assets/images/cat_cloth_1.png',
        price: 49.99,
        formattedDate: 'April, 06',
      ),
    ];
  }

  @override
  Future<void> submitReview(OrderReviewModel review) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _reviews.add(review);
  }
}
