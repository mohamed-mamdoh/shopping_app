
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/login_model/login_model.dart';

import 'package:shopping_app/modules/shop_app/register/cubit_register/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super (ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
    UserModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url:REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone

        },
    ).then((value){
      print(value?.data);
      loginModel=UserModel.fromJson(value?.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));

    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix= isPassword ? Icons.visibility_outlined: Icons.visibility_off_outlined;

    emit(ShopChangePasswordRegVisibilityState());


  }

}