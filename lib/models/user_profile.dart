class OrderSummary {
  final String orderId;
  final DateTime date;
  final double totalAmount;
  final int itemCount;
  final String status;

  const OrderSummary({
    required this.orderId,
    required this.date,
    required this.totalAmount,
    required this.itemCount,
    required this.status,
  });
}

class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String avatarUrl;
  final List<OrderSummary> orderHistory;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatarUrl,
    required this.orderHistory,
  });

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? address,
    String? avatarUrl,
    List<OrderSummary>? orderHistory,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      orderHistory: orderHistory ?? this.orderHistory,
    );
  }
}
