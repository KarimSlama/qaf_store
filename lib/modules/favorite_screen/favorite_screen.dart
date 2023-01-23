import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/models/get_favorites_model.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavoritesDataLoading,
          builder: (context) {
            if (HomeCubit.getContext(context).favorites.isNotEmpty) {
              return buildGridWidget(
                  HomeCubit.getContext(context).favoritesModel!, context);
            } else
              return Image(
                image: NetworkImage(
                  'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg?w=2000',
                ),
              );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  } //end build()

  Widget buildGridWidget(FavoritesModel favoritesModel, context) => Column(
        children: [
          GridView.count(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.1,
            children: List.generate(
              HomeCubit.getContext(context).favoritesModel!.data!.data!.length,
              (index) => buildFavoriteItems(
                  favoritesModel.data!.data![index], context),
            ),
          ),
        ],
      );

  Widget buildFavoriteItems(FavoritesDataModel favoritesModel, context) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                        '${favoritesModel.product!.image}',
                      ),
                      width: 200.0,
                      height: 200.0,
                    ),
                    if (favoritesModel.product!.discount != 0)
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
                        '${favoritesModel.product!.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            '${favoritesModel.product!.price}' '\$',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 9.0,
                          ),
                          if (favoritesModel.product!.oldPrice != 0)
                            Text(
                              '${favoritesModel.product!.oldPrice}' '\$',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                HomeCubit.getContext(context)
                    .changeFavorites(favoritesModel.product!.id!);
              },
              icon: HomeCubit.getContext(context)
                      .favorites[favoritesModel.product!.id]!
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
