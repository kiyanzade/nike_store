import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoging = true;
  final TextEditingController usernameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Theme(
      data: themeData.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor:
                MaterialStateProperty.all(themeData.colorScheme.secondary),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
          ),
        ),
        colorScheme: themeData.colorScheme.copyWith(
          onSurface: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          // inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/nike_logo.png',
                  color: Colors.white, width: 120),
              const SizedBox(
                height: 24,
              ),
              Text(
                isLoging ? 'خوش آمدید' : 'ثبت نام',
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                isLoging
                    ? 'لطفا اطلاعات کاربری خود را وارد کنید'
                    : 'ایمیل و رمز عبور خود را تعیین کنید',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('آدرس ایمیل'),
                ),
              ),
              const SizedBox(height: 16),
              _PasswordWidget(
                passwordController: passwordController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {
                    authRepository.login(
                        usernameController.text, passwordController.text);
                  },
                  child: Text(isLoging ? 'ورود' : 'ثبت نام')),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoging ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoging = !isLoging;
                      });
                    },
                    child: Text(
                      isLoging ? 'ثبت نام' : 'ورود',
                      style: TextStyle(
                          color: themeData.colorScheme.primary,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  const _PasswordWidget({
    super.key,
    required this.passwordController,
  });

  @override
  State<_PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<_PasswordWidget> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: value,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                value = !value;
              });
            },
            icon: Icon(
              value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          label: const Text('رمز عبور')),
    );
  }
}
