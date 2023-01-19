import 'package:flutter/material.dart';

import './cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int totalItemsInCart = 0;
    for (var cartItem in _items.entries) {
      totalItemsInCart += cartItem.value.quantity;
    }
    return totalItemsInCart;
  }

  double get totalAmount {
    double summ = 0.0;
    _items.forEach(
      (key, cartItem) {
        summ += cartItem.price * cartItem.quantity;
      },
    );
    return summ;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeItemQuantity(String productId, int quantity) {
    if (quantity <= 1) {
      _items.removeWhere((key, value) => key == productId);
    } else {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
          title: existingCartItem.title,
        ),
      );
    }
    notifyListeners();
  }

  void addItemQuantity(String productId, int quantity) {
    _items.update(
      productId,
      (existingCartItem) => CartItem(
        id: existingCartItem.id,
        price: existingCartItem.price,
        quantity: existingCartItem.quantity + 1,
        title: existingCartItem.title,
      ),
    );
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (exitingCartItem) => CartItem(
          id: exitingCartItem.id,
          price: exitingCartItem.price,
          title: exitingCartItem.title,
          quantity: exitingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
