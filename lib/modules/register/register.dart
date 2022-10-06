import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_applications/layout/shop_layout.dart';
import 'package:flutter_applications/modules/register/cubit/register_cubit.dart';
import 'package:flutter_applications/modules/register/cubit/register_states.dart';
import 'package:flutter_applications/shared/components/components.dart';
import 'package:flutter_applications/shared/constants/conistants.dart';
import 'package:flutter_applications/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.putData(
                  key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                        (route) => false);
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Let\'s Get Started',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Register now to browse our hot offers !',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        inputField(
                          preIcon: Icon(Icons.person_outline_rounded),
                          label: 'User Name',
                          type: TextInputType.name,
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        inputField(
                          preIcon: Icon(Icons.email_outlined, size: 20,),
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        inputField(
                          preIcon: Icon(Icons.lock_outline_rounded, size: 20,),
                          sufIcon: IconButton(
                              icon: RegisterCubit.get(context).sufIcon,
                              onPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          label: 'Password',
                          type: TextInputType.text,
                          controller: passwordController,
                          isPassword: RegisterCubit.get(context).isVisible,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        inputField(
                          preIcon: Icon(Icons.phone_android_rounded,size: 20,),
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: phoneController,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: state is !RegisterLoadingState,
                            builder: (context)=> Container(
                              width: 160,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);

                                    toastBuilder(message: 'Successfully created', type: ToastType.Success);

                                  } else
                                  toastBuilder(message: 'Failed to create account', type: ToastType.Error);
                                },
                                child: Text(
                                  'CREATE',
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ),
                            ),
                            fallback: (context)=> Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Login'),
                            )
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
