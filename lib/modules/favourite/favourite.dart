import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is !GetFavoriteDataLoadingState,
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => favoriteItem(ShopCubit.get(context).favoritesModel.data.data[index].product, context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(color: Colors.grey, height: 1,),
                ),
                itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
          );
        }
    );
  }
}
