import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/ui/home/bloc/home_bloc.dart';

import '../../data/repo/banner_repository.dart';
import '../../data/repo/product_repository.dart';
import '../widgets/bannerSlider.dart';
import '../widgets/imageService.dart';

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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Image.asset(
                              'assets/images/nike_logo.png',
                              height: 24,
                            ),
                          );
                        case 2:
                          return BannerSlider(
                            banners: state.banners,
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
