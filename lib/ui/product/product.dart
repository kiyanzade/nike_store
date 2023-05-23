import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/details.dart';

import '../../data/product.dart';
import '../widgets/imageService.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, left: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
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
                  SizedBox(
                    height: 189,
                    width: 186,
                    child: ImageLoadingService(
                        imageUrl: product.imageUrl,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(CupertinoIcons.heart),
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
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.previousPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    Text(product.price.withPriceLabel),
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
