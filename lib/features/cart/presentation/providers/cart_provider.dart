import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:souq_app/features/cart/data/repositroy/cart_repository_impl.dart';
import 'package:souq_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:souq_app/features/cart/domain/repository/cart_repository.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

class CartNotifier extends Notifier<List<CartItemEntity>> {
  late final CartRepository _cartRepository;

  @override
  List<CartItemEntity> build() {
    _cartRepository = ref.watch(cartRepositoryProvider);
    return _cartRepository.getSavedCart();
  }

  void addToCart(ProductEntity product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      final updatedList = List<CartItemEntity>.from(state);
      final currentItem = updatedList[existingIndex];
      updatedList[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + 1,
      );
      state = updatedList;
    } else {
      state = [...state, CartItemEntity(product: product, quantity: 1)];
    }

    _cartRepository.saveCart(state);
  }

  void removeFromCart(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
    _cartRepository.saveCart(state);
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    state = state.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    _cartRepository.saveCart(state);
  }

  void clearCart() {
    state = [];
    _cartRepository.clearCart();
  }
}
final cartNotifierProvider =
    NotifierProvider<CartNotifier, List<CartItemEntity>>(CartNotifier.new);

final cartTotalAmountProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartNotifierProvider);
  return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
});

final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartNotifierProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final localDataSource = ref.watch(cartLocalDataSourceProvider);
  return CartRepositoryImpl(localDataSource);
});