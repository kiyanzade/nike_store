import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/bloc/product_bloc.dart';
import 'package:nike_store/ui/product/comment/comment_list.dart';
import 'package:nike_store/ui/widgets/imageService.dart';

import '../../data/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductState>? subscription = null;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final productBloc = ProductBloc(cartRepository);
          subscription = productBloc.stream.listen((state) {
            if (state is ProductAddToCartSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد')));
            } else if (state is ProductAddToCartErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.appException.message)));
            }
          });
          return productBloc;
        },
        child: Scaffold(
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 48,
            child: BlocBuilder<ProductBloc,ProductState>(
              builder: (BuildContext context, state) {
                return FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(CartAddButtonClickEvent(widget.product.id));
                    },
                    label: (state is ProductAddtoCartButtonLoadingState)
                        ? CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Text('افزودن به سبد خرید'));
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace: ImageLoadingService(
                    imageUrl: widget.product.imageUrl,
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
                          widget.product.title,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.caption!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(widget.product.price.withPriceLabel),
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
              CommentList(productId: widget.product.id),
            ],
          ),
        ),
      ),
    );
  }
}
