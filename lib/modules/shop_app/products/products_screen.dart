
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/categories_model/categories_model.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/models/home_model/home_model.dart';
import 'package:shopping_app/shared/styles/colors.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
       listener: (context,state){},
         builder: (context,state){
         return ConditionalBuilder(
             condition:ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categoriesModel != null,
             builder:(context)=>productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!),
             fallback:(context)=> const Center(child: CircularProgressIndicator()),
         );
      },

    );


  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel )=>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
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
    height: 250,
    //aspectRatio: 16/9,
    viewportFraction: 1.0,
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
        const SizedBox(
          height: 10.0,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                  'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,


                ),

              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder:(context,index)=> buildCategoryItem(categoriesModel.data!.data![index]),
                    separatorBuilder:(context,index)=>const SizedBox(width: 10.0,),
                    itemCount:categoriesModel.data!.data!.length,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,


                ),

              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],

          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio:1/1.58,
            children:List.generate(
              model.data!.products.length,
                  (index) =>buildGridProduct(model.data!.products[index]),

            ),

          ),
        ),


      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment:AlignmentDirectional.bottomCenter,
    children:
    [
       Image(
        image:NetworkImage('${model.image}',),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8,),
        width:100.0,
        child: Text(
          '${model.name}',
          textAlign:TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),

        ),


      ),

    ],
  );
  Widget buildGridProduct(ProductModel model)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
              image:NetworkImage(model.image) ,
              width: double.infinity,
              //fit: BoxFit.cover,
              height: 200.0,
              ),
              if(model.discount !=0)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,

                  ),
                ),
              ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}\$',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,),
                    if(model.discount !=0)
                      Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color:Colors.grey,
                        decoration:TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                        onPressed:(){},
                        icon:const Icon(
                          Icons.favorite_border,
                         // size: 16.0,
                        ),
                    ),

                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
