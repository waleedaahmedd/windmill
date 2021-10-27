import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

class SubFilterList extends StatefulWidget {
  final String categoryTitle;

  SubFilterList({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  State<SubFilterList> createState() => _SubFilterListState();
}

class _SubFilterListState extends State<SubFilterList> {
  List<bool> expansionList = [
    false,
  ];

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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (true) {
                  return ExpansionList(
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, bool) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  "List of categories in dropdown",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontFamily: "DINNextLTPro_Medium",
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        body: ExpansionPanelBodyGrid(
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryDropdownListCard(
                              title: "Category",
                              isSelected: index % 2 != 0,
                            );
                          },
                          itemCount: 3,
                        ),
                        isExpanded: expansionList[0],
                        backgroundColor: AppColors.appWhiteColor,
                        canTapOnHeader: true,
                      ),
                    ],
                    expansionCallback: (index, isOpen) =>
                        expansionCallback(index, isOpen),
                  );
                } else {
                  return SubCategoryFilterListCard(
                    title: "Category $index",
                    isSelected: false,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void expansionCallback(
    int index,
    bool isOpen, {
    bool isDateList = false,
  }) {
    expansionList[index] = !isOpen;
    if (mounted) setState(() {});
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
            style: TextStyle(
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
              style: TextStyle(
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
