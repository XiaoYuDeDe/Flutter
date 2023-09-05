import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/widgets/common_widgets.dart';
import 'package:travelguide/pages/home/bloc/home_blocs.dart';
import 'package:travelguide/pages/home/bloc/home_states.dart';
import 'package:travelguide/pages/home/home_controller.dart';
import 'package:travelguide/pages/home/widget/home_widgets.dart';
import '../../common/global/global.dart';
import '../attractions/attractions.dart';
import 'bloc/home_events.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static void updateAverageRating() {
    final _HomeState homeState = _HomeState();
    homeState.loadAttractions();
  }
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    //Reset the HomeDot position
    context.read<HomeBlocs>().add(const HomeDotEvents(0));
    //load attractions data
    loadAttractions();
  }
  
  void loadAttractions(){
    //fetch Top attractions
    HomeController(context: context).fetchAttractions(true,true);
    //fetch All attractions
    HomeController(context: context).fetchAttractions(false,false);
  }

  @override
  Widget build(BuildContext context) {
    //get user profile
    final userInfo = Global.storageService.getUserInfo();
    final username = userInfo["username"];

    return BlocBuilder<HomeBlocs, HomeStates>(builder: (context, state) {
      return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: commonAppBarWidget("Home",
              titleColor: AppColors.contentTitleColor, showBackButton: false),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: homeTitle("Hello, $username", fontSize: 24),
                ),
                SliverToBoxAdapter(
                  child: homeTitle("Let's Explore Travels!",
                      textColor: AppColors.contentColor, top: 5, fontSize: 18),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 10.h)),
                SliverToBoxAdapter(
                  child: slideViewWidget(context, state),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        width: 325.w,
                        margin: EdgeInsets.only(top: 15.h),
                        child: Row(
                          children: [
                            textWidget("Recommendations",
                                color: AppColors.pageTitleColor, fontSize: 20)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Row(
                          children: [
                            buttonWidget("All", state, onPressed: () {
                              context
                                  .read<HomeBlocs>()
                                  .add(const BtnSelectedNameEvents("All"));
                              HomeController(context: context)
                                  .fetchAttractions(false,false);
                            }),
                            buttonWidget("Popular", state, onPressed: () {
                              context
                                  .read<HomeBlocs>()
                                  .add(const BtnSelectedNameEvents("Popular"));
                              HomeController(context: context)
                                  .fetchAttractions(false,true);
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 1.5,
                            mainAxisExtent: 200),
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.attractionsList.length,
                      (BuildContext context, int index) {
                        final attraction = state.attractionsList[index];
                        return GestureDetector(
                          onTap: () async {
                            final clickBack = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    AttractionsDetail(attraction: attraction),
                              ),
                            );
                            if (clickBack!=null && clickBack) {
                              //reload to refresh average rating
                              HomeController(context: context).fetchAttractions(true,true);
                              HomeController(context: context).fetchAttractions(false,false);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.w),
                              color: AppColors.gridColor,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.w),
                                      topRight: Radius.circular(15.w),
                                    ),
                                    image: attraction.imageUrl != ""
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                attraction.imageUrl),
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: Text(
                                              attraction.name,
                                              style: TextStyle(
                                                color: AppColors.contentTitleColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color:
                                                      AppColors.iconColor),
                                              Text(
                                                attraction.averageRating
                                                    .toString(),
                                                style: TextStyle(
                                                  color: AppColors.contentTitleColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/icons/location.png",
                                            width: 20.w,
                                            height: 20.h,
                                            color: AppColors.iconColor,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            attraction.city,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    });
  }
}
