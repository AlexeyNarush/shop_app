import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../models/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.title, this.imageUrl, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shadowColor: Theme.of(context).accentColor,
        elevation: 3,
        child: ListTile(
          tileColor: Theme.of(context).primaryColor,
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 110,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ProductsProvider>(context).deliteProduct(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
