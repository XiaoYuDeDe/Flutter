import 'package:travelguide/entities/attraction.dart';

abstract class AttractionManagementEvents{
  const AttractionManagementEvents();
}

class AttractionResultsEvent extends AttractionManagementEvents{
  final List<Attraction> attractionResults;
  const AttractionResultsEvent(this.attractionResults);
}
