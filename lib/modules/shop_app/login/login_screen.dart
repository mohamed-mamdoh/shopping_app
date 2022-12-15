import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/shop_layout/shop_layout.dart';
import 'package:shopping_app/modules/shop_app/login/cubit_login/cubit.dart';
import 'package:shopping_app/modules/shop_app/login/cubit_login/states.dart';
import 'package:shopping_app/modules/shop_app/register/register_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/components/constans.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';


class LoginScreen extends StatelessWidget {
  
  var formKye=GlobalKey<FormState>();

  LoginScreen({super.key});

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(

      create: (BuildContext context)=>ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){

          if(state is ShopLoginSuccessState){

            if(state.loginModel.status!){
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(key:'token', value:state.loginModel.data!.token).then((value) {
                token=state.loginModel.data?.token;
                navigateAndFinish(context,const ShopLayout());
              });
              showToast(
              state:ToastState.success,
                  text:state.loginModel.message.toString()
              );
            }else{
              print(state.loginModel.message);
              showToast(
                  text:state.loginModel.message.toString(),
                  state:ToastState.error,
              );
            }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),

            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKye,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',

                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        defaultFormField(
                          controller:emailController,
                          type: TextInputType.emailAddress,

                          validate:(String value){
                            if(value.isEmpty){
                              return 'Please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,

                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          controller:passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword:ShopLoginCubit.get(context).isPassword,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value){
                            if(formKye.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },

                          validate:(String value){
                            if(value.isEmpty){
                              return 'Password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,

                        ),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState ,
                          builder: (context)=>defaultButton(
                            function:(){
                              if(formKye.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }

                            },
                            text:'login',
                          ),
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\t have an account'),
                            defaultTextButton(
                              function: (){
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
