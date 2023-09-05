import '../../../entities/attraction.dart';

class HomeStates{
  final int index;
  final String btnSelectedName;
  final List<Attraction> topAttractions;
  final List<Attraction> attractionsList;

  const HomeStates({
    this.index = 0,
    this.btnSelectedName = "All",
    List<Attraction>? topAttractions,
    List<Attraction>? attractionsList,
  })  : topAttractions = topAttractions ?? const [],
        attractionsList = attractionsList ?? const []; // Assign empty list if attractionsList is not provided

  HomeStates copyWith({
    int? index,
    String? btnSelectedName,
    List<Attraction>? topAttractions,
    List<Attraction>? attractionsList}){

    return HomeStates(
        index:index??this.index,
        btnSelectedName: btnSelectedName ?? this.btnSelectedName,
        topAttractions: topAttractions ?? this.topAttractions,
        attractionsList: attractionsList ?? this.attractionsList
    );
  }

  HomeStates resetIndex() {
    return HomeStates(
      index: 0, //
      btnSelectedName: btnSelectedName,
    );
  }
}
