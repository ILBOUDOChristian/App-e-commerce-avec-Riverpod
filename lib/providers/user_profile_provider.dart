import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

final _initialMockUser = UserProfile(
  id: 'usr_101',
  fullName: 'Alexandre Dupont',
  email: 'alexandre.dupont@example.com',
  phone: '+33 6 12 34 56 78',
  address: '142 Avenue des Champs-Élysées, 75008 Paris, France',
  avatarUrl:
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=80',
  orderHistory: [
    OrderSummary(
      orderId: 'CMD-2026-889',
      date: DateTime.now().subtract(const Duration(days: 4)),
      totalAmount: 189.99,
      itemCount: 1,
      status: 'Livrée',
    ),
    OrderSummary(
      orderId: 'CMD-2026-742',
      date: DateTime.now().subtract(const Duration(days: 18)),
      totalAmount: 98.40,
      itemCount: 2,
      status: 'Livrée',
    ),
  ],
);

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(_initialMockUser);

  void updateProfile({
    String? fullName,
    String? email,
    String? phone,
    String? address,
  }) {
    state = state.copyWith(
      fullName: fullName,
      email: email,
      phone: phone,
      address: address,
    );
  }
}

/// [Provider 6] StateNotifierProvider pour l'état du profil utilisateur mocké
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});
