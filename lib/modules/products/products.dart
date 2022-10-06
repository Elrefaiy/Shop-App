import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/models/categories.dart';
import 'package:flutter_applications/models/home.dart';
import 'package:flutter_applications/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state){
        if(state is FavoritesChangeSuccessState){
          if(!state.model.status){
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) => ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(ShopCubit.get(context).homeModel, ShopCubit.get(context).categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator(),) ,
      ),
    );
  }

  Widget productBuilder(HomeModel homeModel, CategoriesModel categoriesModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(
          items: homeModel.data.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList(),
          options: CarouselOptions(
            height: 170,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 10,),
              Container(
                height: 130,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => categoriesItem(categoriesModel.data.data[index], context),
                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                    itemCount: categoriesModel.data.data.length,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'New Products',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey[400],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.33,
            children:
            List.generate(
                homeModel.data.products.length,
                    (index) => gridItem(homeModel.data.products[index], context),
            ),
          ),
        ),
      ],
    ),
  );
}


