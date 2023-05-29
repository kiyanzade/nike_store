import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        actions: [
          IconButton(
              onPressed: () {
                CartRepository.cartItemCountNotifier.value = 0;
                authRepository.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 65,
                  height: 65,
                  margin: const EdgeInsets.only(top: 8, bottom: 20),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black.withOpacity(0.1), width: 1)),
                  child: Image.asset('assets/images/nike_logo.png')),
              const Text('sasalsllasml@gmail.com'),
              const Divider(
                height: 24,
                thickness: 0.5,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.heart),
                    SizedBox(
                      width: 16,
                    ),
                    const Text('لیست علاقه‌مندی ها'),
                  ],
                ),
              ),
              const Divider(
                height: 24,
                thickness: 0.5,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.cart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('سوابق سفارش'),
                  ],
                ),
              ),
              const Divider(
                height: 24,
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
