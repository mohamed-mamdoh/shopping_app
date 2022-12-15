
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shopping_app/modules/shop_app/search/cubit/states.dart';
import 'package:shopping_app/shared/components/components.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var searchController=TextEditingController();
    return  BlocProvider(

      create: (BuildContext context) =>SearchCubit(),
      
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(),
            body:Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate:(String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'enter text to search';
                          }

                        },
                        onSubmit: (String text)
                        {
                          SearchCubit.get(context).search(text);

                        },
                        label: 'Search ',
                        prefix: Icons.search,
                    ),
                    const SizedBox(height: 10.0,),
                    if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10.0,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemCount:SearchCubit.get(context).model!.data!.data!.length,
                        separatorBuilder:(context,index)=>myDivider(),
                        itemBuilder: (context,index) => buildListProducts(
                          SearchCubit.get(context).model!.data?.data![index],
                              context,isOldPrice: false) ,

                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}