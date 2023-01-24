import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/models/search_model.dart';
import 'package:qaf_store/shared/components/constants.dart';
import 'package:qaf_store/shared/cubit/states/search_states.dart';
import 'package:qaf_store/shared/data/network/dio_helper.dart';
import 'package:qaf_store/shared/data/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitializeState());

  static SearchCubit getContext(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void searchItems(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  } //end searchItems()
} //end class
