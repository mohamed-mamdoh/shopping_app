
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/search_model/search_model.dart';

import 'package:shopping_app/modules/shop_app/search/cubit/states.dart';
import 'package:shopping_app/shared/components/constans.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context) =>BlocProvider.of(context);
  SearchModel? model;

  Future<void>search(String text) async
  {
    emit(SearchLoadingState());
    await DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text':text,
        },
    ).then((value) {
      model=SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });

  }
}