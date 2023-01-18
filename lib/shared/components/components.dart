import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/shared/styles/colors.dart';
import 'package:shopping_app/shared/styles/styles.dart';






  Widget buildArticleItem(article,context)=>InkWell(
    onTap: (){

      navigateTo(context,WebViewScreen(article['url']));
    },
    child: Padding(
     padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image:  DecorationImage(
            image:  NetworkImage(
             '${article['urlToImage']}',

           ),
            fit: BoxFit.cover,
         ),
         ),
          ),
            const SizedBox(width: 20.0,),
            Expanded(
                  child: Container(
                  height: 120.0,
                      child: Column(

                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children:  [
                         Expanded(

                            child: Text(
                          ' ${article['title']}',
                           style: Theme.of(context).textTheme.bodyText1,
                           maxLines: 3,
                           overflow: TextOverflow.ellipsis,
                              ),
                          ),
                          Text(
                          '${article['publishedAt']}',
                           style: const TextStyle(
                           color: Colors.grey,

                       ),
                        ),

                       ],
                        ),
                        ),
                          ),
                            ],
                              ),
                                  ),
  );

class WebViewScreen {
  WebViewScreen(article);
}

  Widget myDivider()=>Padding(
    padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
   child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
   );
  Widget articleBuilder(list,context)=>ConditionalBuilder(

    condition:list.isNotEmpty,
    builder: (context)=>ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: 15,
    ),
    fallback: (context)=>const Center(child: CircularProgressIndicator()),

  );

TextFormField defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  required Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  bool isPassword=false,
}) =>
    TextFormField(
      controller: controller,
      validator: (s) {
        var res = validate!(s);
        return res;
      },
      keyboardType: type,
      obscureText:isPassword ,
      onChanged: (s) => onChanged?.call(s),
      onFieldSubmitted: (s) => onSubmit?.call(s),
      onTap: () => onTap?.call(),
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix!=null?IconButton(

          onPressed:()=>suffixPressed?.call(),

          icon: Icon(suffix),

        ):null,

      ),
    );
Widget defaultButton({
  required Function function,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(
        onPressed:()=> function.call(),
        child: Text(
          text.toUpperCase(),
          style: white14bold(),
        ),
      ),
    );
Widget defaultTextButton({
  required Function function,
  required String text,
})=>TextButton(
  onPressed:()=>function.call(),
  child:Text(text.toUpperCase()),
);

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder:(context)=>widget,
)
);
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context)=>widget, ),
    (Route<dynamic>route)=>false,
);

void showToast({
  required String text,
  required ToastState state
})=>Fluttertoast.showToast(
msg:text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor:chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastState{success,error,warning}

Color? chooseToastColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.success:
      color= Colors.green;
      break;
    case ToastState.warning:
      color= Colors.amber;
      break;
    case ToastState.error:
      color= Colors.red;
      break;
  }
  return color;

}

Widget buildListProducts( model,context,{bool isOldPrice=true,})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
              image:NetworkImage(model.image) ,
              width: 120,
              fit: BoxFit.cover,
              height: 120.0,
            ),
            if(model.discount !=0 && isOldPrice)
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
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.toString()}\$',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,),
                  if(model.discount !=0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 10.0,
                        color:Colors.grey,
                        decoration:TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed:()
                    {
                      ShopCubit.get(context).changeFavorites(productId:model.id!);

                      //print(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey ,
                      child: const Icon(
                        Icons.favorite_border,
                        color:Colors.white ,
                        // size: 16.0,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);