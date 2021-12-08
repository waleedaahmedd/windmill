import 'package:get_storage/get_storage.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class PersistentStorage {
  static const String CATEGORY = "CATEGORY";
  GetStorage _storage = GetStorage(Common.PERSISTENT_STORAGE);

  List<Category>? getSelectedCategories(int categoryID) {
    List<dynamic> _categories = _storage.read("$categoryID$CATEGORY");
    List<Category> _selectedCategories = [];
    _categories.forEach((category) {
      _selectedCategories.add(Category.fromJson(category));
    });
    return _selectedCategories;
  }

  void setCategoryList(List<Category> categoryList, int categoryID) {
    _storage.write("$categoryID$CATEGORY", categoryList);
    return;
  }
}
