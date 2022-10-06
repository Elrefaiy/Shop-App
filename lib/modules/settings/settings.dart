import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/shared/components/components.dart';
import 'package:flutter_applications/shared/constants/conistants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var model = ShopCubit.get(context).userModel;
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context,state){
        },
        builder: (context,state){
          nameController.text =  model.data.name;
          emailController.text =  model.data.email;
          phoneController.text =  model.data.phone;

          return ConditionalBuilder(
              condition: model != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/second.jpg'),
                          width: 290,
                        ),
                        SizedBox(height: 20),
                        inputField(
                          preIcon: Icon(Icons.person),
                          label: 'User Name',
                          type: TextInputType.name,
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        inputField(
                          preIcon: Icon(Icons.email),
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        inputField(
                          preIcon: Icon(Icons.phone),
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: phoneController,
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if(formKey.currentState.validate()){

                                ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );

                                Fluttertoast.showToast(
                                    msg: 'Updated Successfully',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                              }else{
                                Fluttertoast.showToast(
                                    msg: 'Updated Failed',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text(
                              'UPDATE INFO',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(context: context,
                                builder: (context)=> AlertDialog(
                                  titleTextStyle: Theme.of(context).textTheme.headline2,
                                  title: Text('Are you sure ?'),
                                  content: Text('You want to Logout from this account'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){logout(context);},
                                      child: Text('Logout'),
                                    ),
                                    TextButton(
                                      onPressed: (){Navigator.pop(context);},
                                      child: Text('Cancel'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'LOGOUT',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(context: context,
                                builder: (context)=> AlertDialog(
                                  titleTextStyle: Theme.of(context).textTheme.headline2,
                                  title: Text('Are you sure ?'),
                                  content: Text('You want to exit " Salla Store "'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){exit(0);},
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: (){Navigator.pop(context);},
                                      child: Text('No'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'EXIT',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        }
    );
  }
}


