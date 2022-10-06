import 'package:flutter/material.dart';
import 'package:flutter_applications/modules/search/cubit/search_cubit.dart';
import 'package:flutter_applications/modules/search/cubit/search_states.dart';
import 'package:flutter_applications/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:Row(
                mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Salla', style: GoogleFonts.pacifico(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),),
                Text('Store',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, size: 20,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent, width: 2.5),
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                      onFieldSubmitted: (text) {
                        SearchCubit.get(context).searchProduct(text: text);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => searchItem(SearchCubit.get(context).searchModel.data.data[index], context),
                          separatorBuilder: (context, index) => Container(
                            color: Colors.grey,
                            height: 1,
                          ),
                          itemCount: SearchCubit.get(context).searchModel.data.data.length,
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
