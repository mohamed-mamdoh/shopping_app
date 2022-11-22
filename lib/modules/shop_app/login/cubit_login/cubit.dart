
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/login_model/login_model.dart';
import 'package:shopping_app/modules/shop_app/login/cubit_login/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit():super (ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
    UserModel? loginModel;
  void userLogin({
  required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url:LOGIN,
        data: {
          'email':email,
          'password':password,

        },
    ).then((value){
      print(value.data);
      loginModel=UserModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));

    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix= isPassword ? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());


  }

}