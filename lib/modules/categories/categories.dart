import 'package:flutter/material.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => categoriesScreenItem(ShopCubit.get(context).categoriesModel.data.data[index], context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(color: Colors.grey, height: 1,),
              ),
              itemCount: ShopCubit.get(context).categoriesModel.data.data.length );
        }
    );
  }
}
