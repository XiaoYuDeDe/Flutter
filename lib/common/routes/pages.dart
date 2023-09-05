import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/attractions/bloc/attractions_blocs.dart';
import 'package:travelguide/pages/favorite/bloc/favorites_blocs.dart';
import 'package:travelguide/pages/home/bloc/home_blocs.dart';
import 'package:travelguide/pages/home/home.dart';
import 'package:travelguide/pages/login/bloc/login_blocs.dart';
import 'package:travelguide/pages/login/login.dart';
import 'package:travelguide/pages/management/attractions/attraction_management.dart';
import 'package:travelguide/pages/management/category/bloc/category_management_blocs.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_blocs.dart';
import 'package:travelguide/pages/navigation/navigation.dart';
import 'package:travelguide/pages/profile/profile.dart';
import 'package:travelguide/pages/register/bloc/register_blocs.dart';
import 'package:travelguide/pages/register/register.dart';
import 'package:travelguide/pages/search/search.dart';
import 'package:travelguide/pages/welcome/bloc/welcome_blocs.dart';
import 'package:travelguide/pages/welcome/welcome.dart';
import '../../pages/management/attractions/add_attraction/bloc/add_attraction_blocs.dart';
import '../../pages/management/attractions/bloc/attraction_management_blocs.dart';
import '../../pages/management/category/category_management.dart';
import '../../pages/profile/bloc/profile_blocs.dart';
import '../../pages/profile/settings/bloc/settings_blocs.dart';
import '../../pages/profile/settings/settings.dart';
import '../../pages/search/bloc/bloc/search_blocs.dart';
import '../global/global.dart';
import 'routes.dart';

class AppPages{
  static List<PageEntity> routes = [
    PageEntity(
        route: AppRoutes.INITIAL,
        page: const Welcome(),
        bloc: BlocProvider(create: (_)=>WelcomeBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.LOGIN,
        page: const Login(),
        bloc: BlocProvider(create: (_)=>LoginBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.REGISTER,
        page: const Register(),
        bloc: BlocProvider(create: (_)=>RegisterBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.NAVIGATION,
        page: const Navigation(),
        bloc: BlocProvider(create: (_)=>NavigationBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.HOME,
        page: const Home(),
        bloc: BlocProvider(create: (_)=>HomeBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.SEARCH,
        page: const Search(),
        bloc: BlocProvider(create: (_)=>SearchBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.FAVORITES,
        page: const Search(),
        bloc: BlocProvider(create: (_)=>FavoritesBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.PROFILE,
        page: const Profile(),
        bloc: BlocProvider(create: (_)=>ProfileBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.ATTRACTIONS,
        page: const Search(),
        bloc: BlocProvider(create: (_)=>AttractionsBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.SETTINGS,
        page: const Settings(),
        bloc: BlocProvider(create: (_)=>SettingsBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.CATEGORY_MANAGEMENT,
        page: const CategoryManagement(),
        bloc: BlocProvider(create: (_)=>CategoryManagementBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.ATTRACTION_MANAGEMENT,
        page: const AttractionManagement(),
        bloc: BlocProvider(create: (_)=>AttractionManagementBlocs(),)
    ),
    PageEntity(
        route: AppRoutes.ADD_ATTRACTION,
        page: const AttractionManagement(),
        bloc: BlocProvider(create: (_)=>AddAttractionBlocs(),)
    ),

  ];

  static List<dynamic> allBlocProviders(BuildContext context){
    List<dynamic> blocProviders = <dynamic>[];
    for(var route in routes){
      blocProviders.add(route.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRoutesSettings(RouteSettings settings){
    if(settings.name!=null){//check route name matching when navigator gets triggered.
      var result = routes.where((element) => element.route==settings.name);
      if(result.isNotEmpty){
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        //check whether user has opened it or not
        // if(result.first.route==AppRoutes.INITIAL&&deviceFirstOpen){
        //   //check whether user is logged in or not
        //   bool isLoggedIn = Global.storageService.getIsLoggedIn();
        //   if(isLoggedIn){
        //     return MaterialPageRoute(builder: (_)=>const Navigation(), settings:settings);
        //   }
        //   return MaterialPageRoute(builder: (_)=>const Login(), settings: settings);
        // }
        return MaterialPageRoute(builder: (_)=>result.first.page, settings: settings);
      }
    }
    //if can not matching return to login page.
    return MaterialPageRoute(builder: (_)=>const Login(), settings:settings);
  }
}

//list routes and block provider and pages.
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, required this.bloc});
}