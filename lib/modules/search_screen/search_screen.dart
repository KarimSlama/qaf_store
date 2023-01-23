import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/models/search_model.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/cubit/search_cubit.dart';
import 'package:qaf_store/shared/cubit/states/search_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchCubit = SearchCubit.getContext(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  textForm(
                    inputType: TextInputType.text,
                    controller: searchController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'enter text to search for';
                      }
                      return null;
                    },
                    label: 'search for product',
                    prefixIcon: Icons.search_outlined,
                    color: HexColor('2F3D64'),
                    onSubmit: (text) {
                      searchCubit.searchItems(text);
                    },
                    height: 60.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (state is SearchLoadingState)
                    LinearProgressIndicator(
                      backgroundColor: HexColor('FFDD00'),
                      color: HexColor('2F3D64'),
                      minHeight: 2,
                    ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildSearchProductsList(
                          SearchCubit.getContext(context)
                              .searchModel!
                              .data!
                              .data![index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.black12.withOpacity(
                              .1,
                            ),
                          ),
                        ),
                        itemCount: SearchCubit.getContext(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } //end build()

  Widget buildSearchProductsList(
    Product model,
    context, {
    bool isOldPrice = true,
  }) =>
      SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadiusDirectional.circular(5.0)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}' '\$',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}' '\$',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.getContext(context).changeFavorites(
                            model.id!,
                          );
                        },
                        icon: HomeCubit.getContext(context).favorites[model.id!]!
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
                ],
              ),
            ),
          ],
        ),
      );
} //end class
