import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/widgets/common_widgets.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/attractions/attractions_controller.dart';
import 'package:travelguide/pages/attractions/bloc/attractions_blocs.dart';
import 'package:travelguide/pages/attractions/bloc/attractions_states.dart';
import '../../common/global/global.dart';
import '../../entities/attraction.dart';
import 'widget/attractions_widget.dart';
import 'bloc/attractions_events.dart';

class AttractionsDetail extends StatefulWidget {
  final Attraction attraction;

  const AttractionsDetail({Key? key, required this.attraction}) : super(key: key);

  @override
  State<AttractionsDetail> createState() => _AttractionsDetailState();
}

class _AttractionsDetailState extends State<AttractionsDetail> {
  late Attraction _attraction;

  late String userId;
  late String userName;

  @override
  void initState() {
    super.initState();
    //receive parameter
    _attraction = widget.attraction;

    final userInfo = Global.storageService.getUserInfo();
    userId = userInfo["userId"];
    userName = userInfo["username"];
    //init reviews list
    AttractionsController(context: context).getAttractionReviews(context,_attraction.attractionId);
    //init average rating
    context.read<AttractionsBlocs>().add(AverageRatingEvent(_attraction.averageRating));
    AttractionsController(context: context).isFavorite(context, userId, _attraction.attractionId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttractionsBlocs, AttractionsStates>(
      builder: (context, state){
        return WillPopScope(
          onWillPop: () async {
            bool clickBack = true;
            Navigator.pop(context, clickBack);
            // Return true to allow the app to pop
            return true;
          },
          child: Scaffold(
            appBar:commonAppBarWidget(_attraction.name, titleColor: AppColors.contentTitleColor),
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          _attraction.imageUrl,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _attraction.name, //attraction name
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: AppColors.iconColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        state.averageRating.toString(), //attraction averageRating
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/location.png",
                                    width: 20.w,
                                    height: 20.h,
                                    color: AppColors.iconColor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    _attraction.city, //attraction city
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      if(state.isFavorite){
                                        context.read<AttractionsBlocs>().add(IsFavoriteEvent(false));
                                        AttractionsController(context: context)
                                            .removeFavorite(context, userId, _attraction.attractionId);
                                      }else{
                                        context.read<AttractionsBlocs>().add(IsFavoriteEvent(true));
                                        AttractionsController(context: context)
                                            .addFavorite(context, userName, userId, _attraction);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: state.isFavorite ? AppColors.iconColor : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _attraction.description, //attraction description
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Reviews",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Column(
                                              children: [
                                                Text(
                                                  "Leave a review for this attraction",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: state.rating,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 30,
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: AppColors.iconColor,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    context.read<AttractionsBlocs>().add(RatingChangedEvent(rating));
                                                  },
                                                ),
                                                const SizedBox(height: 20),
                                                TextField(
                                                  maxLength: 100,
                                                  onChanged: (text) {
                                                    context.read<AttractionsBlocs>().add(CommentEvent(text));
                                                  },
                                                  maxLines: 5,
                                                  decoration: InputDecoration(
                                                    hintText: "Write your review...",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: const BorderSide(color: AppColors.linkColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(//cancel
                                                onPressed: () {
                                                  context.read<AttractionsBlocs>().add(RatingChangedEvent(0.0));
                                                  context.read<AttractionsBlocs>().add(CommentEvent(""));
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(//confirm
                                                onPressed: () async {
                                                  final double rating = context.read<AttractionsBlocs>().state.rating;
                                                  final String comment = context.read<AttractionsBlocs>().state.comment;
                                                  final String attractionId = _attraction.attractionId;
                                                  if(rating == 0){
                                                    toastInfo(msg: "You haven't rated yet.");
                                                    return;
                                                  }
                                                  if(comment.isEmpty){
                                                    toastInfo(msg: "You haven't left a comment.");
                                                    return;
                                                  }
                                                  await AttractionsController(context: context).addReviews(attractionId, userName, rating, comment);
                                                  context.read<AttractionsBlocs>().add(RatingChangedEvent(0.0));
                                                  context.read<AttractionsBlocs>().add(CommentEvent(""));
                                                  await AttractionsController(context: context).getAttractionReviews(context,attractionId);
                                                  await AttractionsController(context: context).updateAverageRating(context,attractionId);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Submit"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "Write a Review",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.linkColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              reviewsWidget(context, userId, _attraction.attractionId, state.reviewsResult)
                              // ...
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        );
        // return ;
      }
    );
  }
}