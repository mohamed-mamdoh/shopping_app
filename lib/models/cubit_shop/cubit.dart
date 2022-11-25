

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model/categories_model.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/models/home_model/home_model.dart';
import 'package:shopping_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shopping_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shopping_app/modules/shop_app/products/products_screen.dart';

import 'package:shopping_app/modules/shop_app/setting/setting_screen.dart';
import 'package:shopping_app/shared/components/constans.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> bottomScreens=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
   HomeModel? homeModel;
  Future<void> getHomeData()async{
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(
      url:HOME,
      token:token,
    ).then((value){
      homeModel=HomeModel.fromJson(value?.data);
      print("homeModel status is ${homeModel!.status}");
      print('banner is ${homeModel!.data!.banners}');
      print(homeModel?.data!.banners[0].image);
      emit(ShopSuccessHomeDataState(homeModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });

  }

  CategoriesModel? categoriesModel;
  Future<void> getCategories()async{

    await DioHelper.getData(
      url:GET_CATEGORIES,
      token:token,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value?.data);

      emit(ShopSuccessCategoriesState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });

  }

}
