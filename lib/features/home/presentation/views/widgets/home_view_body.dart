import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:notes_app/features/home/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    return const Padding(
      padding:   EdgeInsets.symmetric(horizontal: 16),
      child:  Column(
        children: [
          CustomListView()
        ],
      ),
      
    );
  }
}


