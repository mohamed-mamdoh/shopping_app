
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/shared/components/components.dart';




class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder: (context,state){
        return ConditionalBuilder
          (
            condition: state is! ShopLoadingGetFavoritesState ,
            builder:(context)=> ListView.separated(
              itemCount:ShopCubit.get(context).favoritesModel!.data!.data!.length,
              separatorBuilder:(context,index)=>myDivider(),
              itemBuilder: (context,index) =>buildListProducts(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context) ,

            ),
            fallback: (context) =>const Center(child: CircularProgressIndicator()),

        );


      },
    );
  }


}

// Widget buildFavItem(Product model,context)=>Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Container(
//     height: 120.0,
//     child: Row(
//        crossAxisAlignment: CrossAxisAlignment.start,
//       children:
//       [
//         Stack(
//           alignment: AlignmentDirectional.bottomStart,
//           children:
//           [
//              Image(
//               image:NetworkImage(model.image) ,
//               width: 120,
//               fit: BoxFit.cover,
//               height: 120.0,
//             ),
//             if(model.discount !=0)
//               Container(
//                 color: Colors.red,
//                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                 child: const Text(
//                   'DISCOUNT',
//                   style: TextStyle(
//                     fontSize: 10.0,
//                     color: Colors.white,
//
//                   ),
//                 ),
//               ),
//
//           ],
//         ),
//         const SizedBox(
//           width: 20.0,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children: [
//                Text(
//                 model.name!,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 14.0,
//                   height: 1.3,
//                 ),
//               ),
//               const Spacer(),
//               Row(
//                 children: [
//                    Text(
//                     '${model.price.toString()}\$',
//                     style: const TextStyle(
//                       fontSize: 12.0,
//                       color: defaultColor,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 5.0,),
//                   if(model.discount !=0)
//                      Text(
//                       model.oldPrice.toString(),
//                       style: const TextStyle(
//                         fontSize: 10.0,
//                         color:Colors.grey,
//                         decoration:TextDecoration.lineThrough,
//                       ),
//                     ),
//                   const Spacer(),
//                   IconButton(
//                     padding: EdgeInsets.zero,
//                     onPressed:()
//                     {
//                       ShopCubit.get(context).changeFavorites(productId:model.id!);
//
//                       //print(model.id);
//                     },
//                     icon: CircleAvatar(
//                       radius: 15.0,
//                       backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey ,
//                       child: const Icon(
//                         Icons.favorite_border,
//                         color:Colors.white ,
//                         // size: 16.0,
//                       ),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// )

