import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/shop_layout/shop_layout.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/modules/shop_app/login/login_screen.dart';
import 'package:shopping_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shopping_app/shared/components/constans.dart';

import 'package:shopping_app/shared/cubit/bloc_observer.dart';
import 'package:shopping_app/shared/cubit_app/cubit.dart';
import 'package:shopping_app/shared/cubit_app/states.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';
import 'package:shopping_app/shared/styles/themes.dart';

import 'shared/network/local/cache_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  dynamic isDark= CacheHelper.getBoolData(key:'isDark');
  Widget widget;
  dynamic onBoarding=await CacheHelper.getData(key: 'onBoarding');
  token = await CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding!=null)
  {
    if(token!=null) {
      widget=  const ShopLayout();
    } else{widget=LoginScreen();}
  }
  else{
    widget= const OnBoardingScreen();
  }

  runApp( MyApp(
    startWidget:widget, isDark:isDark,
  ));
}

class MyApp extends StatelessWidget {
   bool isDark;
   Widget startWidget;

   MyApp( {super.key, required this.isDark, required this.startWidget});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider( create: (BuildContext context)=>AppCubit()..changeAppMode(
          fromShared:isDark ,
        ),),
        BlocProvider( create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),

      ],
      child:BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme ,
            darkTheme:darkTheme,
            themeMode:AppCubit.get(context).isDark?ThemeMode.light:ThemeMode.dark,
            home:startWidget,
          );
        },
      ),
    );
  }
}


