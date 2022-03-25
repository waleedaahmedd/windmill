import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';

import '../../../search_provider.dart';

class WindmillAppBar extends StatefulWidget {
  const WindmillAppBar({
    Key? key,
    this.title,
    this.controller,
    this.hamburgerIconColor,
    this.needSearchBar = false,
    this.needBackIcon = false,
    this.appBarColor,
    this.appBarTrailingIcon,
    this.onDrawerTap,
    this.onBackTap,
    this.titleTS,
    this.backIconColor,
    this.drawerColor = "white",
  }) : super(key: key);
  final TextEditingController? controller;
  final Color? hamburgerIconColor, appBarColor, backIconColor;
  final String? title, drawerColor;
  final bool needSearchBar, needBackIcon;
  final Widget? appBarTrailingIcon;
  final TextStyle? titleTS;
  final VoidCallback? onDrawerTap, onBackTap;

  @override
  _WindmillAppBarState createState() => _WindmillAppBarState();
}

class _WindmillAppBarState extends State<WindmillAppBar> {
  CancelableOperation? cancelableOperation;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProductProvider>(builder: (context, i, _) {
      return Container(
        color: widget.appBarColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.needBackIcon
                        ? InkWell(
                            onTap: widget.onBackTap ??
                                () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: widget.backIconColor ??
                                  ((widget.appBarColor == null)
                                      ? AppColors.appBlackColor
                                      : AppColors.appWhiteColor),
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                      child: widget.title != null
                          ? Text(
                              "${widget.title}",
                              style: widget.titleTS ??
                                  GoogleFonts.poppins(
                                    color: AppColors.appWhiteColor
                                        .withOpacity(0.7),
                                  ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox(),
                    ),
                    widget.appBarTrailingIcon ??
                        Image.asset(
                          "${Common.assetsImages}application_icon.png",
                          height: 25.0,
                        ),
                  ],
                ),
                widget.needSearchBar
                    ? const SizedBox(height: 10.0)
                    : const SizedBox(),
                widget.needSearchBar
                    ? Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: widget.controller,
                                    onChanged: (value) {
                                      {
                                        cancelableOperation?.cancel();
                                        cancelableOperation =
                                            CancelableOperation.fromFuture(
                                                Future.delayed(
                                                    Duration(seconds: 1),
                                                    () async {
                                          if (value != '') {
                                            await Provider.of<
                                                        SearchProductProvider>(
                                                    context,
                                                    listen: false)
                                                .getProducts(value);
                                          }

                                          // API call here
                                        }));
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Please enter a search term')),
                              ),
                              Visibility(
                                  visible: i.searchLoading,
                                  child: CupertinoActivityIndicator()),
                              Visibility(
                                  visible: widget.controller!.text == '' ||
                                           i.searchLoading
                                      ? false
                                      : true,
                                  child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        cancelableOperation!.cancel();
                                        widget.controller!.text = '';
                                        i.clearProductList();
                                       /* cancelableOperation!.value.whenComplete(
                                            () => {i.clearProductList()});*/
                                      },
                                      child: Icon(Icons.clear))),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }

/*cancelOnChange(String value) */
}
