import 'package:flutter/material.dart';
import 'package:nike_store/ui/home/home.dart';

class PriceInfo extends StatelessWidget {
  final int payablePrice;
  final int shippingPrice;
  final int totalPrice;

  const PriceInfo(
      {super.key,
      required this.payablePrice,
      required this.shippingPrice,
      required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
          child: Text(
            'جزئیات خرید',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(8, 4, 8, 32),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                ),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('مبلغ کل خرید'),
                    Text(
                      totalPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Divider(height: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('هزینه ارسال'),
                    Text(
                      shippingPrice == 0
                          ? 'رایگان'
                          : shippingPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Divider(height: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('مبلغ قابل پرداخت'),
                    RichText(
                      text: TextSpan(
                          text: payablePrice.separateByComma,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18),
                          children: [
                            TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 12),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
