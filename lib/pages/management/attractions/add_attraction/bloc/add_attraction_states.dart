import 'dart:io';

import '../../../../../entities/category.dart';

class AddAttractionStates{
  final String attractionId;
  final String name;
  final String city;
  final String categoryId;
  final String description;
  final double averageRating;
  final String imageUrl;
  final List<Category> categoryResults;
  final File? selectedImage;

  const AddAttractionStates({
    this.attractionId="",
    this.name="",
    this.city="",
    this.categoryId="",
    this.description="",
    this.averageRating=0.0,
    this.imageUrl="",
    this.categoryResults=const[],
    this.selectedImage
  });

  AddAttractionStates copyLastObject({
    String? attractionId,
    String? name,
    String? city,
    String? categoryId,
    String? description,
    double? averageRating,
    String? imageUrl,
    List<Category>? categoryResults,
    File? selectedImage,
  }){
    return AddAttractionStates(
        attractionId:attractionId??this.attractionId,
        name:name??this.name,
        city:city??this.city,
        categoryId:categoryId??this.categoryId,
        description:description??this.description,
        averageRating:averageRating??this.averageRating,
        imageUrl:imageUrl??this.imageUrl,
        categoryResults:categoryResults??this.categoryResults,
        selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}