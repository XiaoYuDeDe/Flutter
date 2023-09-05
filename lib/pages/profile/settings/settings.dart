import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/widgets/common_widgets.dart';
import 'package:travelguide/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:travelguide/pages/profile/settings/bloc/settings_states.dart';
import 'package:travelguide/pages/profile/settings/widget/settings_widget.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: commonAppBarWidget("Settings", titleColor: AppColors.appBarColor),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs, SettingsStates>(
          builder:(context, state){
            return Column(
              children: [
                settingsLogoutWidget(context)
              ],
            );
        }),
      ),
    );
  }
}
