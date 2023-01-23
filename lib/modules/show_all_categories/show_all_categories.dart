import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/models/category_model.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';

class ShowAllCategories extends StatelessWidget {
  const ShowAllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'All Categories',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gabriola',
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) => buildCategoriesList(
                HomeCubit.getContext(context)
                    .categoryModel!
                    .data!
                    .data![index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.black12,
              ),
            ),
            itemCount:
                HomeCubit.getContext(context).categoryModel!.data!.data!.length,
          );
        },
      ),
    );
  } //end build()

  Widget buildCategoriesList(DataModel dataModel) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                '${dataModel.image}',
              ),
              width: 120.0,
              height: 120.0,
            ),
            const SizedBox(
              width: 25.0,
            ),
            Text(
              '${dataModel.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
} //end class
