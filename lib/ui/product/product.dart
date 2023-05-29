import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/details.dart';

import '../../data/product.dart';
import '../widgets/imageService.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, left: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: widget.product,
            ),
          ));
        },
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.95,
                    child: ImageLoadingService(
                        imageUrl: widget.product.imageUrl,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: InkWell(
                      onTap: () {
                        if (!favoritesManager.isFavorites(widget.product)) {
                          favoritesManager.addFavorites(widget.product);
                        } else {
                          favoritesManager.delete(widget.product);
                        }

                        setState(() {});
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: favoritesManager.isFavorites(widget.product)
                            ? Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              )
                            : Icon(CupertinoIcons.heart),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      widget.product.title,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.product.previousPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    Text(widget.product.price.withPriceLabel),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
