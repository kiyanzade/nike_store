import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/ui/home/home.dart';

import '../../data/cart_itam.dart';
import 'imageService.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem, required this.onDeleteButtonTapped,
  });

  final CartItem cartItem;
  final Function() onDeleteButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageLoadingService(
                      imageUrl: cartItem.product.imageUrl,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cartItem.product.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تعداد',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.plus_rectangle)),
                        Text(
                          cartItem.count.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.minus_rectangle)),
                      ],
                    )
                  ],
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    cartItem.product.previousPrice.withPriceLabel,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  Text(cartItem.product.price.withPriceLabel),
                ])
              ],
            ),
          ),
          const Divider(
            height: 10,
          ),
          TextButton(
              onPressed: onDeleteButtonTapped,
              child: cartItem.deleteButtonLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : Text('حذف از سبد خرید')),
        ],
      ),
    );
  }
}
