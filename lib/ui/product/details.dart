import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/comment/comment_list.dart';
import 'package:nike_store/ui/widgets/imageService.dart';

import '../../data/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
              onPressed: () {}, label: Text('افزودن به سبد خرید')),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(
                  imageUrl: product.imageUrl,
                  borderRadius: BorderRadius.circular(0)),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        product.title,
                        style: Theme.of(context).textTheme.headline6,
                      )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product.previousPrice.withPriceLabel,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          Text(product.price.withPriceLabel),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                      'توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول'),
                  SizedBox(height: 24),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کاربران',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextButton(onPressed: () {}, child: Text('ثبت نظر'))
                      ]),
                ]),
              ),
            ),
            CommentList(productId: product.id),
          ],
        ),
      ),
    );
  }
}
