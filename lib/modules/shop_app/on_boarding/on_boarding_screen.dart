

 import 'package:flutter/material.dart';
import 'package:shopping_app/modules/shop_app/login/login_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {


  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    boarding= [
      BoardingModel(
          image:'images/onboard.jpg' ,
          title:'On Board 1 Title',
          body:'On Board 1 Body'),
      BoardingModel(
          image:'images/onboard.jpg' ,
          title:'On Board 2 Title',
          body:'On Board 2 Body'),
      BoardingModel(
          image:'images/onboard.jpg',
          title:'On Board 3 Title',
          body:'On Board 3 Body'),
    ];


    super.initState();
  }
   var boardController=PageController();
   bool isLast=false;
   void submit(){
     CacheHelper.saveData(key: 'onBoarding', value:true).then((value) {
       if(value!){navigateAndFinish(context, LoginScreen());}
     });


   }

   late List<BoardingModel>boarding;


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         actions: [
           TextButton(
               onPressed:(){
                 submit();
                 //navigateAndFinish(context, LoginScreen());
               },
               child: const Text('SKIP',),
           ),
         ],
       ),
       body:Padding(
         padding: const EdgeInsets.all(30.0),
         child: Column(
           children: [

             Expanded(
               child: PageView.builder(
                 physics: const BouncingScrollPhysics(),
                   controller: boardController,
                   onPageChanged: (int index){
                   if(index==boarding.length-1){
                     setState(() {
                       isLast=true;
                     });
                   }else{
                     setState(() {
                       isLast=false;
                     });
                   }
                   },
                   itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                 itemCount:boarding.length,

               ),
             ),
             const SizedBox(
               height: 40.0,
             ),
             Row(
               children:  [
                 SmoothPageIndicator(
                     controller:boardController,
                     effect: const ExpandingDotsEffect(
                       dotColor: Colors.grey,
                       activeDotColor: defaultColor,
                       dotHeight: 10,
                       dotWidth: 10,
                       expansionFactor: 4,
                       spacing: 5.0,
                     ),
                     count: boarding.length,

                 ),
                 const Spacer(),
                 FloatingActionButton(
                   onPressed:(){
                     if(isLast){
                       submit();
                       //navigateAndFinish(context,  LoginScreen());
                     }else {
                       boardController.nextPage(
                         duration: const Duration(
                           microseconds: 750,
                         ),
                         curve: Curves.fastLinearToSlowEaseIn,
                       );
                     }
                   },
                   child: const Icon(Icons.arrow_forward_ios),
                 ),

               ],
             ),
           ],
         ),
       ),

     );
   }

   Widget buildBoardingItem(BoardingModel model)=>Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children:   [

       Expanded(
         child: Image(
           image:AssetImage(model.image),

         ),
       ),
       const SizedBox(
         height: 30.0,
         ),
       Text(
         model.title,
         style: const TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
           fontSize:24.0,
         ),
       ),
       const SizedBox(
         height: 15.0,
       ),
       Text(
         model.body,
         style: const TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
           fontSize:14.0,
         ),
       ),
       const SizedBox(height: 30.0,),
     ],
   );
}
 