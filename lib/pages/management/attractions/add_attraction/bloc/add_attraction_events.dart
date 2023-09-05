import 'dart:io';

import '../../../../../entities/category.dart';

abstract class AddAttractionEvents{
  const AddAttractionEvents();
}

class AttractionIdEvent extends AddAttractionEvents{
  final String attractionId;
  const AttractionIdEvent(this.attractionId);
}

class NameEvent extends AddAttractionEvents{
  final String name;
  const NameEvent(this.name);
}

class CityEvent extends AddAttractionEvents{
  final String city;
  const CityEvent(this.city);
}

class CategoryIdEvent extends AddAttractionEvents{
  final String categoryId;
  const CategoryIdEvent(this.categoryId);
}

class DescriptionEvent extends AddAttractionEvents{
  final String description;
  const DescriptionEvent(this.description);
}

class AverageRatingEvent extends AddAttractionEvents{
  final double averageRating;
  const AverageRatingEvent(this.averageRating);
}

class ImageUrlEvent extends AddAttractionEvents{
  final String imageUrl;
  const ImageUrlEvent(this.imageUrl);
}

class CategoryResultsEvent extends AddAttractionEvents{
  final List<Category> categoryResults;
  const CategoryResultsEvent(this.categoryResults);
}

class SelectedImageEvent extends AddAttractionEvents{
  final File selectedImage;
  const SelectedImageEvent(this.selectedImage);
}