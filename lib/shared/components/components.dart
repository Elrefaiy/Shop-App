import 'package:flutter/material.dart';
import 'package:flutter_applications/cubit/shop_cubit.dart';
import 'package:flutter_applications/models/categories.dart';
import 'package:flutter_applications/models/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Widget inputField({
  @required preIcon,
  @required label,
  @required type,
  @required controller,
  isPassword = false,
  sufIcon,
  Function submit,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal:5.0),
  child:   Container(
    height: 50,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.grey[350], blurRadius: 5, spreadRadius: 3,)
        ]
    ),
    child:TextFormField(
      style: GoogleFonts.mPlusRounded1c(
        fontSize: 14,
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
      ),
      obscureText: isPassword,
      keyboardType: type,
      validator: (value) {
        if (value.isEmpty) return '$label is Empty !';
        return null;
      },
    ),
  ),
);

Widget gridItem(ProductModel model, context) =>
    Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 120,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '${model.price.toString()} EGP ',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),

                if (model.discount != 0)
                  Text(
                    model.oldPrice.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      decoration: TextDecoration.lineThrough,
                      textBaseline: TextBaseline.ideographic,
                    ),
                  ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: ShopCubit.get(context).favorite[model.id]
                      ? Colors.blue
                      : Colors.grey,
                  radius: 18,
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        ShopCubit.get(context).changeFav(model.id);
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );

Widget categoriesItem(DataModel model, context) => Column(
      children: [
        SizedBox(height: 3,),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                  boxShadow: [
                  BoxShadow(color: Colors.grey[700], blurRadius: 6,)
                ]
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.6),
          child: Text(
            model.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

Widget categoriesScreenItem(DataModel model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 6,)
                ]
            ),
            child: Image(
              image: NetworkImage(model.image),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios_outlined), onPressed: () {}),
        ],
      ),
    );

Widget favoriteItem(model, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 120,
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120,
                ),
                if (model.discount > 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    textScaleFactor: 1.2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.toString()} EGP',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      if (model.discount > 0)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favorite[model.id]
                                ? Colors.blue
                                : Colors.grey,
                        radius: 18,
                        child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFav(model.id);
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget searchItem(model, context) => Padding(
  padding: const EdgeInsets.all(10),
  child: Container(
    width: 90,
    height: 90,
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 120,
          height: 120,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                textScaleFactor: 1.2,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                  '${model.price.toString()}  EGP',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor:
                    ShopCubit.get(context).favorite[model.id]
                        ? Colors.blue
                        : Colors.grey,
                    radius: 18,
                    child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFav(model.id);
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

enum ToastType {Success, Warning, Error}
void toastBuilder({
  @required String message,
  @required ToastType type,
}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(type),
      textColor: Colors.white,
      fontSize: 16.0);
}
Color toastColor(ToastType type){
  switch(type){
    case ToastType.Success :
      return Colors.green;
      break;

    case ToastType.Warning :
      return Colors.yellow;
      break;

    case ToastType.Error :
      return Colors.red;
      break;

    default: return Colors.blue;
  }
}