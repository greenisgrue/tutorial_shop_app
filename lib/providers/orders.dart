import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://flutter-tutorial-a9474.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }),
      );
      
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  // Future<void> addProduct(Product product) async {
  //   const url = 'https://flutter-tutorial-a9474.firebaseio.com/products.json';
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'title': product.title,
  //         'description': product.description,
  //         'imageUrl': product.imageUrl,
  //         'price': product.price,
  //         'isFavorite': product.isFavorite,
  //       }),
  //     );
  //     final newProduct = Product(
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //       id: json.decode(response.body)['name'],
  //     );
  //     _items.add(newProduct);
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }
}
