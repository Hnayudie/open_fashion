import 'package:equatable/equatable.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Map<String, dynamic> item;

  AddToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final Map<String, dynamic> item;

  RemoveFromCart(this.item);

  @override
  List<Object> get props => [item];
}