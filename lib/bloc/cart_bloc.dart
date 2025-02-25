import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>((event, emit) {
      final updatedCart = List<Map<String, dynamic>>.from(state.cartItems);
      final index = updatedCart.indexWhere((item) => item['id'] == event.item['id']);

      if (index != -1) {
        // If the item exists, increment the quantity
        final updatedItem = Map<String, dynamic>.from(updatedCart[index]);
        updatedItem['quantity'] = (updatedItem['quantity'] ?? 1) + 1;
        updatedCart[index] = updatedItem; // Update the existing item
      } else {
        // Otherwise, add the item with an initial quantity of 1
        final newItem = Map<String, dynamic>.from(event.item);
        newItem['quantity'] = 1;
        updatedCart.add(newItem);
      }

      emit(CartState(cartItems: updatedCart));
    });

    on<RemoveFromCart>((event, emit) {
      final updatedCart = List<Map<String, dynamic>>.from(state.cartItems);
      final index = updatedCart.indexWhere((item) => item['id'] == event.item['id']);

      if (index != -1) {
        final updatedItem = Map<String, dynamic>.from(updatedCart[index]);

        if ((updatedItem['quantity'] ?? 1) > 1) {
          // Decrease quantity if greater than 1
          updatedItem['quantity'] -= 1;
          updatedCart[index] = updatedItem;
        } else {
          // Remove item if quantity reaches 0
          updatedCart.removeAt(index);
        }
      }

      emit(CartState(cartItems: updatedCart));
    });


  }
}