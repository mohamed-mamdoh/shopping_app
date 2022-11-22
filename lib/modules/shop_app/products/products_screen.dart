
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/models/home_model/home_model.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
       listener: (context,state){},
      builder: (context,state){
         return ConditionalBuilder(
             condition:ShopCubit.get(context).homeModel !=null,
             builder:(context)=>productsBuilder(ShopCubit.get(context).homeModel!),
             fallback:(context)=> const Center(child: CircularProgressIndicator()),
         );
      },

    );


  }

  Widget productsBuilder(HomeModel model )=>Column(
    children: [
       CarouselSlider(
  items: model.data!.banners.map((e){
  return Container(
  clipBehavior: Clip.hardEdge,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
  child: CachedNetworkImage(
      imageUrl:'${e.image}',
      width: double.infinity,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter:
            const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
      ),
    ),
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),

  ),
  );
  }).toList(),
  options: CarouselOptions(
  height: 180,
  aspectRatio: 16/9,
  viewportFraction: 0.8,
  initialPage: 0,
  enableInfiniteScroll: true,
  reverse: false,
  autoPlay: true,
  autoPlayInterval: const Duration(seconds: 3),
  autoPlayAnimationDuration: const Duration(seconds:1),
  autoPlayCurve: Curves.fastOutSlowIn,
  enlargeCenterPage: true,
  scrollDirection: Axis.horizontal,
  )
  ),


    ],
  );
}
