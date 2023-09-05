import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/utils/firebase_helper.dart';
import 'package:travelguide/common/widgets/common_widgets.dart';
import 'package:travelguide/pages/search/bloc/bloc/search_blocs.dart';
import 'package:travelguide/pages/search/bloc/bloc/search_states.dart';
import 'package:travelguide/pages/search/search_controller.dart';
import 'package:travelguide/pages/search/widget/search_widget.dart';
import 'bloc/bloc/search_events.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<String> selectedCategories = [];

  final TextEditingController searchController = TextEditingController();

  //categories collection
  final CollectionReference _categoriesCollection = FirebaseHelper.categoriesCollection;

  @override
  void initState() {
    super.initState();
    // Reset search result
    context.read<SearchBlocs>().add(const SearchResultsEvent([]));
    context.read<SearchBlocs>().add(const SearchTextEvent(''));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBlocs, SearchStates>(
        builder: (context, state){
            return Scaffold(
              appBar: commonAppBarWidget("Search", titleColor: AppColors.appBarColor, showBackButton: false),
              body: Column(
                children: [
                  Container(
                    width: 375.w,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/search_bg.jpg'),//Photo by Andreas Chu on Unsplash
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Discover Your Next Trip",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.bgColor),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 40.0),
                              decoration: BoxDecoration(
                                color: AppColors.bgColor.withOpacity(1), // Set the search box background color with opacity
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  context.read<SearchBlocs>().add(SearchTextEvent(value));
                                  if (selectedCategories.isNotEmpty) {
                                    SearchPageController(context:context).getFilteredAttractions(value,selectedCategories);
                                  } else {
                                    SearchPageController(context: context).searchAttractions(value);
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(5.0),
                    height: 60, // Adjust the height according to your design
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder<QuerySnapshot>(
                        future: _categoriesCollection.get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          final categoryDocs = snapshot.data?.docs ?? [];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: categoryDocs
                                .map((doc) {
                              final category = doc.data() as Map<String, dynamic>;
                              final categoryId = doc.id;
                              final categoryName = category['name'];
                              return Row(
                                children: [
                                  FilterChip(
                                    selected: selectedCategories.contains(categoryId),
                                    label: Text(categoryName),
                                    onSelected: (selected) {
                                      final state = context.read<SearchBlocs>().state;
                                      setState(() {
                                        if (selected) {
                                          selectedCategories.add(categoryId);
                                          SearchPageController(context:context).getFilteredAttractions(state.searchText,selectedCategories);
                                        } else {
                                          selectedCategories.remove(categoryId);
                                          if (selectedCategories.isNotEmpty) {
                                            SearchPageController(context:context).getFilteredAttractions(state.searchText,selectedCategories);
                                          } else {
                                            SearchPageController(context: context).searchAttractions(state.searchText);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10), // Add some spacing between FilterChips
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.searchResults.length,
                      itemBuilder: (context, index) {
                        final attraction = state.searchResults[index];
                        return listViewCardWidget(context, attraction);
                      },
                    ),
                  )
                ],
              ),
            );
        }
    );
  }
}
