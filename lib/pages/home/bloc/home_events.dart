import '../../../entities/attraction.dart';

abstract class HomeEvents{
  const HomeEvents();
}

class HomeDotEvents extends HomeEvents{
  final int index;
  const HomeDotEvents(this.index);
}

class BtnSelectedNameEvents extends HomeEvents{
  final String btnSelectedName;
  const BtnSelectedNameEvents(this.btnSelectedName);
}

class TopAttractionsEvents extends HomeEvents{
  final List<Attraction> topAttractions;
  const TopAttractionsEvents(this.topAttractions);
}

class AttractionListEvents extends HomeEvents{
  final List<Attraction> attractionsList;
  const AttractionListEvents(this.attractionsList);
}