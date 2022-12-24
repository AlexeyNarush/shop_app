import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/models/cart.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
      ),
      direction: DismissDirection.endToStart,
      //
      // ++Part for making sure user wants to remove item from the cart (deemed unnesesary)++
      //
      // confirmDismiss: (direction) {
      //   return showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('Are you sure?'),
      //       content: Text('Do you want to remove the item from the cart?'),
      //       actions: [
      //         FlatButton(
      //           child: Text(
      //             "No",
      //           ),
      //           onPressed: () {
      //             Navigator.of(context).pop(false);
      //           },
      //         ),
      //         FlatButton(
      //           child: Text(
      //             "Yes",
      //           ),
      //           onPressed: () {
      //             Navigator.of(context).pop(true);
      //           },
      //         ),
      //       ],
      //     ),
      //   );
      // },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    '\$$price',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            title: Text(
              title,
            ),
            subtitle: Text(
              'Total: \$' + (price * quantity).toStringAsFixed(2),
            ),
            trailing: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .removeItemQuantity(productId, quantity);
                    },
                  ),
                  Text('${quantity}x'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .addItemQuantity(productId, quantity);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
