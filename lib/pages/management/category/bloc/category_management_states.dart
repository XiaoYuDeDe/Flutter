import '../../../../entities/category.dart';

class CategoryManagementStates{
  final String categoryName;
  final List<Category> categoryResults;

  const CategoryManagementStates({
    this.categoryName="",
    this.categoryResults=const[]
  });

  CategoryManagementStates copyWith({
    String? categoryName,
    List<Category>? categoryResults
  }){
    return CategoryManagementStates(
        categoryName:categoryName??this.categoryName,
        categoryResults:categoryResults??this.categoryResults
    );
  }
}