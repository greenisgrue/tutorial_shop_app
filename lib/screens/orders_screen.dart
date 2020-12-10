import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

// To avoid fetching orders everytime something changes, ex. some dialouge screen pops up. 
// Convert to stateful widget and add 
// Future _ordersFuture;
// Future _obtainOrdersFuture() {
//  return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
// }

// add initState and set _ordersFuture = _obtainOrdersFuture();
// set future: _ordersFuture in builder

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

// One way of fetching orders. Require stateful widget
// var _isLoading = false;
//  @override
//  void initState() {
    // _isLoading = true;

    // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });

    // super.initState();
 // }

  @override
  Widget build(BuildContext context) {
    // Fetching our orders here would be horrible as it would be run several times
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              print(dataSnapshot.error);
              // Do error handling stuff here
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                      ));
            }
          }
        },
      ),
    );
  }
}
