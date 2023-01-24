import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qaf_store/modules/search_screen/search_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoryCubit = HomeCubit.getContext(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              categoryCubit.titles[categoryCubit.currentIndex],
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gabriola',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Image.asset(
                  'assets/images/search.png',
                  width: 30.0,
                  height: 30.0,
                ),
                padding: EdgeInsetsDirectional.only(end: 15.0),
              ),
            ],
          ),
          body: categoryCubit.screens[categoryCubit.currentIndex],
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: GNav(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.grey.shade800,
                  padding: const EdgeInsets.all(14.0),
                  gap: 8.0,
                  onTabChange: (index) {
                    categoryCubit.changeBottomNav(index);
                  },
                  selectedIndex: categoryCubit.currentIndex,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.category_outlined,
                      text: 'Products',
                    ),
                    GButton(
                      icon: Icons.add_shopping_cart_outlined,
                      text: 'Cart',
                    ),
                    GButton(
                      icon: Icons.favorite_border_outlined,
                      text: 'Favorite',
                    ),
                    GButton(
                      icon: Icons.person_outline,
                      text: 'Profile',
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
