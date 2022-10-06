import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/layout/shop_layout.dart';
import 'package:flutter_applications/modules/login/login.dart';
import 'package:flutter_applications/on_boarding/on_boarding.dart';
import 'package:flutter_applications/shared/network/local/cache_helper.dart';
import 'package:flutter_applications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'modules/login/cubit/bloc_observer.dart';
import 'shared/constants/conistants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else
    widget = OnBoardingScreen();

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
      child: BlocConsumer <ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.blueAccent,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                color: Colors.white,
                elevation: 0,
              ),
              textTheme: TextTheme(
                headline1: GoogleFonts.pacifico(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                headline2: GoogleFonts.pacifico(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                headline3: GoogleFonts.mPlusRounded1c(
                  color: Colors.grey[700],
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),

              ),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey[400],
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,

              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
