import 'package:travelguide/entities/attraction.dart';

class AttractionManagementStates{
  final List<Attraction> attractionResults;

  const AttractionManagementStates({
    this.attractionResults=const[]
  });

  AttractionManagementStates copyWith({
    List<Attraction>? attractionResults
  }){
    return AttractionManagementStates(
        attractionResults:attractionResults??this.attractionResults
    );
  }
}