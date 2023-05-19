import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/ui/home/bloc/home_bloc.dart';

import '../../data/repo/banner_repository.dart';
import '../../data/repo/product_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            productRepository: productRepository,
            bannerRepository: bannerRepository);
        homeBloc.add(HomeStartedEvent());
        return homeBloc;
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              if (state is HomeSuccessState) {
                return ListView.builder(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 100),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Image.asset(
                            'assets/images/nike_logo.png',
                            height: 32,
                          );
                        default:
                          return Container();
                      }
                    });
              } else if (state is HomeLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is HomeErrorState) {
                return Column(
                  children: [
                    Text(state.exception.message),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(HomeRefreshEvent());
                        },
                        child: Text('تلاش مجدد'))
                  ],
                );
              } else
                throw Exception('state is not supported');
            },
          ),
        ),
      ),
    );
  }
}
