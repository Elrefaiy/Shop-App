import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/modules/search/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Salla', style: GoogleFonts.pacifico(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),),
                Text('Store',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: InkWell(
                  highlightColor: Colors.white,
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  child: Container(
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.white, size: 20,),
                          Text(' Search', )
                        ],
                      ),
                    ),
                    alignment: AlignmentDirectional.centerStart,
                  ),
                ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories',),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite',),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings',),
            ],
            onTap: (index){
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
