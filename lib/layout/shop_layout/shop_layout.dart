
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/modules/shop_app/search/search_screen.dart';
import 'package:shopping_app/shared/components/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(

            title: const Text(
              'Salla',
            ),
            actions: [
              IconButton(
                  onPressed:(){
                    navigateTo(context,const SearchScreen());
                  },
                  icon:const Icon(Icons.search),
              ),
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon:Icon(Icons.home,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.apps,),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.favorite,),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.settings,),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
