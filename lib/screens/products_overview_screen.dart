import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      // Gridview, only load items on the screen. Good for long lists
      body: ProductsGrid(),
    );
  }
}


