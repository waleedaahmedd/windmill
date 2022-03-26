import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class SubFilterList extends StatefulWidget {
  final String categoryTitle;
  final int categoryId;

  SubFilterList({
    Key? key,
    required this.categoryTitle,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<SubFilterList> createState() => _SubFilterListState();
}

class _SubFilterListState extends State<SubFilterList> {
  List<Category>? _categories; // all categories received from api
  List<Category> _parentCategories = <Category>[]; // parent categories only
  List<Category> _selectedCategories =
      <Category>[]; // empty list in start // child categories
  bool _isLoading = true; // loading in start till categories are all loaded

  //persistent storage
  PersistentStorage _persistentStorage = PersistentStorage();

  @override
  void initState() {
    super.initState();
    _getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WindmillAppBar(
            needBackIcon: Navigator.of(context).canPop(),
            title: "${widget.categoryTitle}",
            titleTS: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          _isLoading
              ? Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _parentCategories.length,
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      Category _category = _parentCategories[index];
                      return CategoryDropdownListCard(
                        title: "${_category.name}",
                        isSelected: _isCategorySelected(_category),
                        onPressed: () => _toggleCategory(_category),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void _getAllCategories() async {
    _categories = await ApiRequests.getAllCategories();
    _populateParentCategoriesList(_categories);
    _getSelectedCategoriesList();
    _isLoading = false;
    setState(() {});
  }

  void _populateParentCategoriesList(List<Category>? categories) {
    if (categories != null) {
      categories.forEach((category) {
        if (category.parent == widget.categoryId)
          _parentCategories.add(category);
      });
    }
  }

  void _getSelectedCategoriesList() {
    _selectedCategories =
        _persistentStorage.getSelectedCategories(widget.categoryId) == null
            ? []
            : _persistentStorage.getSelectedCategories(widget.categoryId)!;
    setState(() {});
  }

  bool _isCategorySelected(Category category) {
    bool _isSelected = false;
    _selectedCategories.forEach((_category) {
      if((category.id == _category.id))
        _isSelected = true;
    });
    return _isSelected;
  }

  void _toggleCategory(Category category) {
    if (_isCategorySelected(category))
      _removeCategory(category);
    else
      _addCategory(category);
    _getSelectedCategoriesList();
  }

  void _removeCategory(Category category) {
    _selectedCategories.remove(category);
    _persistentStorage.setCategoryList(_selectedCategories, widget.categoryId);
  }

  void _addCategory(Category category) {
    _selectedCategories.add(category);
    _persistentStorage.setCategoryList(_selectedCategories, widget.categoryId);
  }
}

class ExpansionList extends StatelessWidget {
  final List<ExpansionPanel> children;
  final Color? dividerColor;
  final Duration? animationDuration;
  final Function(int, bool) expansionCallback;
  const ExpansionList({
    Key? key,
    required this.children,
    required this.expansionCallback,
    this.dividerColor,
    this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      animationDuration: animationDuration ?? Duration(milliseconds: 500),
      dividerColor: dividerColor ?? AppColors.appWhiteColor,
      children: children,
      expansionCallback: expansionCallback,
    );
  }
}

class ExpansionPanelBodyGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final EdgeInsets? padding;
  final ScrollPhysics? scrollPhysics;

  const ExpansionPanelBodyGrid({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.scrollPhysics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding ?? EdgeInsets.zero,
      physics: scrollPhysics ?? BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class SubCategoryFilterListCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  const SubCategoryFilterListCard({
    Key? key,
    required this.isSelected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.appGreyColor.withOpacity(0.1),
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 25.0, 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title",
            style: GoogleFonts.montserrat(
              color:
                  isSelected ? AppColors.appBlackColor : AppColors.appGreyColor,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          isSelected
              ? Icon(
                  CupertinoIcons.checkmark,
                  color: Colors.green,
                  size: 18.0,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CategoryDropdownListCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback? onPressed;

  const CategoryDropdownListCard({
    Key? key,
    required this.title,
    required this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 30.0),
        padding: const EdgeInsets.fromLTRB(
          0.0,
          15.0,
          25.0,
          15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title",
              style: GoogleFonts.montserrat(
                color: AppColors.textColor,
                fontSize: 18.0,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w300,
              ),
            ),
            Icon(
              CupertinoIcons.checkmark,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
