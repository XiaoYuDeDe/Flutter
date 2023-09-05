import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/themes/colors.dart';
import '../../../../common/widgets/toast.dart';
import '../add_attraction/add_attraction.dart';
import '../attraction_management_controller.dart';
import '../bloc/attraction_management_states.dart';

Widget attractionsListWidget(BuildContext context, AttractionManagementStates state){
  return ListView.builder(
    itemCount: state.attractionResults.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Image.network(
          state.attractionResults[index].imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(state.attractionResults[index].name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: AppColors.editIconColor,
              ),
              onPressed: () async {
                String attractionId = state.attractionResults[index].attractionId;
                final saveBack = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AddAttraction(attractionId:attractionId)//edit
                  ),
                );
                if (saveBack!=null && saveBack) {//Return after saving
                  AttractionManagementController(context: context).getAttractions();
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: AppColors.deleteIconColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text('Are you sure you want to delete this attraction?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            String attractionId = state.attractionResults[index].attractionId;
                            String attractionName = state.attractionResults[index].name;
                            await AttractionManagementController(context: context)
                                .deleteAttraction(attractionId,attractionName);
                            await AttractionManagementController(context: context).getAttractions();
                            toastInfo(msg: "Deleted successfully.");
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );

}