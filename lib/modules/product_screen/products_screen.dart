import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/models/favorite_model.dart';
import 'package:qaf_store/models/home_data.dart';
import 'package:qaf_store/modules/about_items_screen/about_items_screen.dart';
import 'package:qaf_store/modules/home_screen/home_screen.dart';
import 'package:qaf_store/modules/search_screen/search_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is FavoritesGetDataSuccess) {
          if (!state.favoriteModel.status!) {
            showToast(
                toastText: '${state.favoriteModel.message}',
                state: ToastBackgroundColor.ERROR);
          }
        }
      },
      builder: (context, state) {
        var homeCubit = HomeCubit.getContext(context);
        return GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: List.generate(
            homeCubit.dataModel!.data.products.length,
            (index) => buildGridProduct(
                homeCubit.dataModel!.data.products[index], context),
          ),
        );
      },
    );
  } //end build()

  Widget buildGridProduct(ProductsModel productsModel, context) => InkWell(
        onTap: () {
          navigateTo(context, AboutItemsScreen(productsModel));
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(productsModel.image),
                      width: 130,
                      height: 130.0,
                    ),
                    if (productsModel.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadiusDirectional.circular(
                            5.0,
                          ),
                        ),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            '${productsModel.price}' '\$',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          if (productsModel.discount != 0)
                            Text(
                              '${productsModel.oldPrice}' '\$',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                HomeCubit.getContext(context).changeFavorites(productsModel.id);
              },
              icon: HomeCubit.getContext(context).favorites[productsModel.id]!
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      );
} //end class
