import 'package:flutter/material.dart';
import 'package:flutter_applications/models/boarding.dart';
import 'package:flutter_applications/modules/login/login.dart';
import 'package:flutter_applications/shared/network/local/cache_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {

  List<Boarding> boarding = [
    Boarding('assets/images/first.jpg',
        'Great Offers Everyday',
        'Be our prime customer to get great offers every day'),

    Boarding('assets/images/second.jpg',
        'New Brands',
        'here You can find your favorites brands'),

    Boarding('assets/images/third.png',
        'Black Friday',
        'Great sales every 7 days, and more'),
  ];

  var boardController = PageController();

  bool isLast = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            CacheHelper.putData(key: 'onBoarding', value: true).then((value){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen(),),
                  (route) => false,
              );
            });
          }, child: Text('SKIP'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index == boarding.length - 1){
                    isLast = true;
                    print('is last');
                  }else{
                    isLast = false;
                    print('not last');
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index], context),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(children: [
              SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: (){
                  if(isLast){
                    CacheHelper.putData(key: 'onBoarding', value: true).then((value){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen(),),
                            (route) => false,
                      );
                    });
                  }else{
                  boardController.nextPage(
                    duration: Duration(milliseconds: 750,),
                    curve: Curves.fastLinearToSlowEaseIn,);
                  }
                },
                child: Icon(Icons.arrow_forward_rounded),)
            ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(Boarding model, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'),width: double.infinity,),),
      Text('${model.heading}', style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.blue, letterSpacing: 1),),
      SizedBox(height: 15,),
      Text('${model.body}', style: GoogleFonts.philosopher(),),
    ],
  );
}
