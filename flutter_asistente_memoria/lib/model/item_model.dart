import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {

  final String name;
  final bool cart;

  const ItemModel(this.name, this.cart) : super();

  @override
  List<Object?> get props => [name, cart];

  static const empty = ItemModel('', false);
}