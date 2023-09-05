import '../../../../entities/category.dart';

abstract class CategoryManagementEvents{
  const CategoryManagementEvents();
}

class CategoryNameEvent extends CategoryManagementEvents{
  final String categoryName;
  const CategoryNameEvent(this.categoryName);
}

class CategoryResultsEvent extends CategoryManagementEvents{
  final List<Category> categoryResults;
  const CategoryResultsEvent(this.categoryResults);
}
