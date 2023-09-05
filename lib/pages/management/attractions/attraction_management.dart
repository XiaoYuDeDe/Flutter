import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/management/attractions/attraction_management_controller.dart';
import 'package:travelguide/pages/management/attractions/widget/attraction_management_widget.dart';

import '../../../common/themes/colors.dart';
import 'add_attraction/add_attraction.dart';
import 'bloc/attraction_management_blocs.dart';
import 'bloc/attraction_management_states.dart';

class AttractionManagement extends StatefulWidget {
  const AttractionManagement({super.key});

  @override
  State<AttractionManagement> createState() => _AttractionManagementState();
}

class _AttractionManagementState extends State<AttractionManagement> {

  @override
  void initState() {
    super.initState();
    //load attraction list
    AttractionManagementController(context: context).getAttractions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttractionManagementBlocs, AttractionManagementStates>(
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              centerTitle: true,
              bottom: PreferredSize(
                //line propriety
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: AppColors.barLineColor,
                  height: 1.0, //height defines the thickness of the line
                ),
              ),
              title: Text(
                "Attraction Management",
                style: TextStyle(
                    color: AppColors.appBarColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    final saveBack = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddAttraction(attractionId:"")//add
                        ),
                    );
                    if (saveBack!=null && saveBack) {//Return after saving
                      AttractionManagementController(context: context).getAttractions();
                    }
                  },
                ),
              ],
            ),
            body: attractionsListWidget(context,state),
          );
        }
    );
  }

}
