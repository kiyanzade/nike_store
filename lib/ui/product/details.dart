import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/bloc/product_bloc.dart';
import 'package:nike_store/ui/product/comment/comment_list.dart';
import 'package:nike_store/ui/product/comment/insert/insert_comment_dialog.dart';
import 'package:nike_store/ui/widgets/image_service.dart';

import '../../data/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductState>? subscription;

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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (BuildContext context, state) {
                return FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(CartAddButtonClickEvent(widget.product.id));
                    },
                    label: (state is ProductAddtoCartButtonLoadingState)
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : const Text('افزودن به سبد خرید'));
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace: ImageLoadingService(
                    imageUrl: widget.product.imageUrl,
                    borderRadius: BorderRadius.circular(0)),
                foregroundColor: LightThemeColors.primaryTextColor,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
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
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.bodySmall!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(widget.product.price.withPriceLabel),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                        'توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول توضیحات محصول'),
                    const SizedBox(height: 24),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نظرات کاربران',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          topLeft: Radius.circular(32))),
                                  context: context,
                                  useRootNavigator: true,
                                  builder: (context) {
                                    return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: InsertCommentDialog(
                                          productId: widget.product.id,
                                        ));
                                  },
                                );
                              },
                              child: const Text('ثبت نظر'))
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
