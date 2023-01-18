import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model/categories_model.dart';
import 'package:shopping_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/models/favorites_model/favorites_model.dart';
import 'package:shopping_app/models/home_model/home_model.dart';
import 'package:shopping_app/models/login_model/login_model.dart';
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
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
   HomeModel? homeModel;
   Map<int,bool>favorites={};
  Future<void> getHomeData()async{
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(
      url:HOME,
      token:token,
    ).then((value){
      homeModel=HomeModel.fromJson(value!.data);
      print("homeModel status is ${homeModel!.status}");
      //print('banner is ${homeModel!.data!.banners}');
      //print(homeModel?.data!.banners[0].image);
      homeModel?.data!.products.forEach((element) 
      {
        favorites.addAll({
          element.id!:element.inFavorites!,
        });
        
      });

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

  ChangeFavoritesModel? changeFavoritesModel;
  Future<void> changeFavorites({required int productId}) async
  {
    favorites[productId] =!favorites[productId]!;
    emit(ShopChangeFavoritesState());
    await DioHelper.postData(
        url:ADD_FAVOURITE,
        token:token,
         data: {
          'product_id':productId,
        },

    ).
    then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value!.data);
      print(value.data);
      if(!changeFavoritesModel!.status!)
      {
        favorites[productId] =!favorites[productId]!;

      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));

    })
        .catchError((onError)
    {
      favorites[productId] =!favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());

    });
  }

  FavoritesModel? favoritesModel;
  Future<void> getFavorites()async{
    emit(ShopLoadingGetFavoritesState());

    await DioHelper.getData(
      url:ADD_FAVOURITE,
      token:token,
    ).then((value){
      favoritesModel=FavoritesModel.fromJson(value?.data);

      emit(ShopSuccessGetFavoritesState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });

  }

  UserModel? userModel;
  Future<void> getUserData()async{
    emit(ShopLoadingGetUserDataState());

    await DioHelper.getData(
      url:PROFILE,
      token:token,
    ).then((value){
      userModel=UserModel.fromJson(value?.data);
      printFullText(userModel!.data!.name);

      emit(ShopSuccessGetUserDataState(userModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });

  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone
  })async{
    emit(ShopLoadingUpdateUserState());

    await DioHelper.putData(
      url:UPDATE_PROFILE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value){
      userModel=UserModel.fromJson(value?.data);
      printFullText(userModel!.data!.name);

      emit(ShopSuccessUpdateUserState(userModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });

  }




}
