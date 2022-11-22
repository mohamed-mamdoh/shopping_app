//

//base url:https://newsapi.org/
//method(url):v2/top-headlines?
//queries:country=eg&apiKey=87fffd0a3b67430b870a569522d54022

//https://newsapi.org/v2/everything?q=tesla&from=2022-08-24&sortBy=publishedAt&apiKey=87fffd0a3b67430b870a569522d54022

import 'package:shopping_app/modules/shop_app/login/login_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';

void sinOut(context){
  CacheHelper.removeData(key:'token').then((value){
    if(value){
      navigateAndFinish(context,LoginScreen(),);
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String? token;
bool boardingShown = false;
bool? tokenStatus;
String? userImage;
String? userPassword;
