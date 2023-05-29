import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/details.dart';
import 'package:nike_store/ui/widgets/imageService.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست علاقه مندی ها'),
      ),
      body: ValueListenableBuilder<Box<Product>>(
        valueListenable: favoritesManager.getValueListenable(),
        builder: (context, box, child) {
          final products = box.values.toList();
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 100),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onLongPress: () {
                  favoritesManager.delete(product);
                },
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: product),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: ImageLoadingService(
                            imageUrl: product.imageUrl,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.caption!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.withPriceLabel),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
