import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<Map<String, dynamic>> cartItems;

  const CartState({this.cartItems = const []});

  int get cartTotal {
    return cartItems.fold(0, (total, item) {
      final price = double.tryParse(item['price'].toString().replaceAll('\$', '')) ?? 0;
      final quantity = (item['quantity'] ?? 1).toInt();
      return total + (price * quantity).toInt();
    });
  }

  @override
  List<Object> get props => [cartItems];

  CartState copyWith({List<Map<String, dynamic>>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}
