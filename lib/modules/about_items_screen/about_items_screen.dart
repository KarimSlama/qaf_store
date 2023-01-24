import 'package:flutter/material.dart';
import 'package:qaf_store/models/home_data.dart';
import 'package:qaf_store/modules/search_screen/search_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';

class AboutItemsScreen extends StatelessWidget {
  final ProductsModel productsModel;

  const AboutItemsScreen(this.productsModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Product',
          style: TextStyle(
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
            padding: const EdgeInsetsDirectional.only(end: 15.0),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(
                productsModel.image,
              ),
              width: double.infinity,
              height: 200.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              productsModel.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gabriola',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(
                    end: 12.0,
                    start: 12.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(40.0),
                      topEnd: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                HomeCubit.getContext(context)
                                    .changeFavorites(productsModel.id);
                              },
                              icon: HomeCubit.getContext(context)
                                      .favorites[productsModel.id]!
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.grey,
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
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${productsModel.price}' '\$',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Gabriola',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          productsModel.description,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     width: double.infinity,
            //     margin: const EdgeInsetsDirectional.only(
            //       end: 20.0,
            //       start: 20.0,
            //     ),
            //     decoration: const BoxDecoration(
            //       color: Colors.black12,
            //       borderRadius: BorderRadiusDirectional.only(
            //         topStart: Radius.circular(40.0),
            //         topEnd: Radius.circular(40.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
