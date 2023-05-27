import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/ui/cart/cart_price_info.dart';

class Shipping extends StatelessWidget {
  final int payablePrice;
  final int shippingPrice;
  final int totalPrice;

  const Shipping(
      {super.key,
      required this.payablePrice,
      required this.shippingPrice,
      required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("تحویل گیرنده"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                label: Text('نام و نام خانوادگی'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('شماره تماس'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('کد پستی'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text('آدرس'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            PriceInfo(
                payablePrice: payablePrice,
                shippingPrice: shippingPrice,
                totalPrice: totalPrice),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text('پرداخت اینترنتی')),
                const SizedBox(
                  width: 16,
                ),
                OutlinedButton(onPressed: () {}, child: const Text('پرداخت در محل')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
