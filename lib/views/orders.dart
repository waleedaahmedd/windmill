import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _isLoading = true;
  String _userID = "";
  UserModal? _user;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _toggleLoading({bool? isLoading}) {
    _isLoading = isLoading ?? !_isLoading;
    if (mounted) setState(() {});
  }

  void _getUser() async {
    int _id = await getInt(Common.ID);
    _userID = _id.toString();
    _user = await ApiRequests.getUser(_userID);

    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindmillAppBar(
            appBarColor: AppColors.appBlueColor,
            needBackIcon: true,
            title: "Orders History",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appWhiteColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: _isLoading
                ? LoadingOverlay()
                : FutureBuilder(
                    future: ApiRequests.getOrders(_userID, _user!.role),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      List<OrderResponseModal> _orderResponse =
                          snapshot.data as List<OrderResponseModal>;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _orderResponse.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return OrderCard(
                            order: _orderResponse[index],
                            user: _user!,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderResponseModal order;
  final UserModal user;
  const OrderCard({
    Key? key,
    required this.order,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onPressed: () => Common.push(
          context,
          OrderDetail(
            order: order,
            user: user,
          )),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.appBlueColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5.0,
                ),
                child: Text(
                  "${order.status}",
                  style: GoogleFonts.montserrat(
                    color: AppColors.appWhiteColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            "OrderID: ${order.orderKey}",
            style: GoogleFonts.montserrat(
              color: AppColors.appBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 0.8,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              Text(
                "Order Amount:",
                style: GoogleFonts.poppins(
                  color: AppColors.appBlackColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  "AED ${order.total}",
                  style: GoogleFonts.poppins(
                    color: AppColors.appGreyColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2.5),
          Row(
            children: [
              Text(
                "Payment Method:",
                style: GoogleFonts.poppins(
                  color: AppColors.appBlackColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  "${order.paymentMethodTitle}",
                  style: GoogleFonts.poppins(
                    color: AppColors.appGreyColor,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Divider(thickness: 1.0),
          const SizedBox(height: 10.0),
          Row(
            children: [
              PrimaryButton(
                title: "View Details",
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
