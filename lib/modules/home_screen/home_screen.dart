import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/models/category_model.dart';
import 'package:qaf_store/models/home_data.dart';
import 'package:qaf_store/modules/show_all_categories/show_all_categories.dart';
import 'package:qaf_store/modules/show_all_screen/show_all_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.getContext(context);
        var categoryCubit = HomeCubit.getContext(context);
        return ConditionalBuilder(
          condition:
              homeCubit.dataModel != null && homeCubit.categoryModel != null,
          builder: (context) => categoryBuilder(
              homeCubit.dataModel!, categoryCubit.categoryModel!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget categoryBuilder(
          HomeModel model, CategoryModel categoryModel, context) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      navigateTo(context, const ShowAllCategories());
                    },
                    child: const Text(
                      'show all',
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
              Container(
                height: 140.0,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      categoryItems(categoryModel.data!.data![index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10.0,
                  ),
                  itemCount: categoryModel.data!.data!.length,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CarouselSlider(
                items: model.data.banners
                    .map((banner) => Image(
                          image: NetworkImage(banner.image),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  scrollDirection: Axis.horizontal,
                  initialPage: 0,
                  height: 190.0,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  reverse: false,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1.0,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    'Recommended products',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      navigateTo(context, ShowAllScreen());
                    },
                    child: const Text(
                      'show all',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 130.0,
                width: double.infinity,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.2,
                  crossAxisCount: 3,
                  children: List.generate(
                    3,
                    (index) => buildGridItem(model.data.products[index]),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'New products',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      navigateTo(context, ShowAllScreen());
                    },
                    child: const Text(
                      'show all',
                    ),
                  ),
                ],
              ),
              Container(
                height: 130.0,
                width: double.infinity,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.2,
                  crossAxisCount: 3,
                  children: List.generate(
                    3,
                    (index) => buildGridItem(model.data.products[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

Widget categoryItems(DataModel dataModel) => Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0XFFFFDD00), width: 1.0),
            borderRadius: BorderRadiusDirectional.circular(10.0),
          ),
          child: Image(
            image: NetworkImage(
              '${dataModel.image}',
            ),
            width: 50.0,
            height: 50.0,
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Text(
          '${dataModel.name}',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

Widget listBuilder(HomeModel model) => Column(
      children: [
        Container(
          height: 115.0,
          width: 100.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3.0,
              color: const Color(0XFFFFDD00),
            ),
            borderRadius: BorderRadiusDirectional.circular(15.0),
          ),
          // child: Image(
          //   image: NetworkImage(
          //     model.data.products[0].image,
          //   ),
          // ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        const Text(
          'Categories',
        ),
      ],
    );

Widget buildGridItem(ProductsModel productsModel) => Container(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                        productsModel.image,
                      ),
                      width: 100.0,
                      height: double.infinity,
                    ),
                    if (productsModel.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(5.0),
                          color: Colors.red,
                        ),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
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
                width: 6.0,
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
            ],
          ),
        ],
      ),
    );

// ListView.separated(
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) =>
// listBuilder(HomeCubit.getContext(context).dataModel!),
// separatorBuilder: (context, index) => const SizedBox(
// width: 20.0,
// ),
// itemCount: 4,
// ),

/*
    Row(
              children: [
                Expanded(
                  child: textForm(
                    color: Colors.grey,
                    height: 50.0,
                    inputType: TextInputType.text,
                    controller: searchController,
                    validate: (value) {},
                    label: 'search',
                    radius: 12.0,
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_shopping_cart, size: 30.0),
                ),
              ],
            ),
 */
