import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/ui/auth/auth.dart';

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
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authInfo, child) {
          final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
          return Center(
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
                  Text(isLogin ? authInfo.email : 'کاربر مهمان'),
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
                        const SizedBox(
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
                  InkWell(
                    onTap: () {
                      if (isLogin) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: const Text('خروج از حساب کاربری'),
                                content: const Text(
                                    'آیا میخواهید از حساب کاربری خود خارج شوید'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        CartRepository
                                            .cartItemCountNotifier.value = 0;
                                        authRepository.signOut();
                                      },
                                      child: const Text('بله')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('خیر'))
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(isLogin
                            ? Icons.exit_to_app_outlined
                            : Icons.login_outlined),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(isLogin
                            ? 'خروج از حساب کاربری'
                            : 'ورود به حساب کاربری'),
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
          );
        },
      ),
    );
  }
}
