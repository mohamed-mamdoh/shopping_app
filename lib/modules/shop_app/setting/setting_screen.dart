
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/cubit_shop/cubit.dart';
import 'package:shopping_app/models/cubit_shop/states.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/components/constans.dart';


class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state)
      {
        if(state is ShopSuccessGetUserDataState)
        {
          nameController.text=state.loginModel.data!.name;
          emailController.text=state.loginModel.data!.email!;
          phoneController.text=state.loginModel.data!.phone;

        }
      },
      builder: (context,state) {

        var model=ShopCubit.get(context).userModel;
        nameController.text=model?.data!.name;
        emailController.text=model!.data!.email!;
        phoneController.text=model.data!.phone;



        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,

          builder: (context)=>Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  const LinearProgressIndicator(),

                  const SizedBox(height: 10.0,),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate:(String value)
                    {
                      if(value.isEmpty){
                        return 'Name Must Not Be Empty';
                      }
                      return null;
                    },
                    label:'Name',
                    prefix:Icons.person,
                  ),
                  const SizedBox(height: 20.0,),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate:(String value)
                    {
                      if(value.isEmpty){
                        return 'Email Must Not Be Empty';
                      }
                      return null;
                    },
                    label:'Email Address',
                    prefix:Icons.email,
                  ),
                  const SizedBox(height: 20.0,),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate:(String value)
                    {
                      if(value.isEmpty){
                        return 'Phone Must Not Be Empty';
                      }
                      return null;
                    },
                    label:'Phone',
                    prefix:Icons.phone,
                  ),
                  const SizedBox(height: 20.0,),
                  defaultButton(
                    function: ()
                    {
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                        );
                      }

                    },
                    text:'UpDate',
                  ),
                  const SizedBox(height: 20.0,),
                  defaultButton(
                      function: ()
                      {
                        signOut(context);
                      },
                      text:'LOGOUT',
                  ),

                ],
              ),
            ),
          ),

          fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}