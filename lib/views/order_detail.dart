import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class OrderDetail extends StatefulWidget {
  final OrderResponseModal order;
  final UserModal user;
  const OrderDetail({
    Key? key,
    required this.order,
    required this.user,
  }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool _isLoading = false;

  void _toggleLoading({bool? isLoading}) {
    _isLoading = isLoading ?? !_isLoading;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindmillAppBar(
            appBarColor: AppColors.appBlueColor,
            needBackIcon: true,
            title: "Order #${widget.order.id}",
            titleTS: GoogleFonts.montserrat(
              color: AppColors.appWhiteColor,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RowHolder(
                      title: "Order ID:",
                      value: "#${widget.order.id}",
                    ),
                    const SizedBox(height: 5.0),
                    RowHolder(
                      title: "Order Key:",
                      value: "#${widget.order.orderKey}",
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Delivery Address:",
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: AppColors.appBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${widget.order.shipping.address1} ${widget.order.shipping.address2}\n${widget.order.shipping.postcode}\n${widget.order.shipping.firstName} ${widget.order.shipping.lastName}\n${widget.order.shipping.phone}",
                      style: GoogleFonts.montserrat(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Payment Method:",
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: AppColors.appBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${widget.order.paymentMethodTitle}",
                      style: GoogleFonts.montserrat(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Ordered Items:",
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: AppColors.appBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.order.lineItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        LineItemm _item = widget.order.lineItems[index];
                        return PrimaryCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 15.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "${_item.name}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  color: AppColors.appBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              RowHolder(
                                title: "Quantity:",
                                value: "${_item.quantity}",
                                titleColor: AppColors.appBlackColor,
                                titleSize: 16.0,
                              ),
                              const SizedBox(height: 5.0),
                              RowHolder(
                                title: "Product Price:",
                                value: "AED ${_item.price}",
                                titleColor: AppColors.appBlackColor,
                                titleSize: 16.0,
                              ),
                              const SizedBox(height: 5.0),
                              RowHolder(
                                title: "Total Price:",
                                value: "AED ${_item.subtotal}",
                                titleColor: AppColors.appBlackColor,
                                titleSize: 16.0,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Total Order Amount:",
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: AppColors.appBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "AED ${widget.order.total}",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          (widget.user.role == Common.DRIVER &&
                  widget.order.status == Common.DRIVER_ASSIGNED)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: PrimaryButton(
                    title: "Mark Order as Delivered",
                    onPressed: () => _processOrderAsDelivered(),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  bool _isDriverUsingAndOrderPaid() {
    return ((widget.user.role == Common.DRIVER) &&
        (widget.order.orderPaidDateTime != null));
  }

  void _processOrderAsDelivered() async {
    if (!_isLoading) {
      _toggleLoading();

      await ApiRequests.markOrderAsCompleted(
        widget.order,
        widget.user,
        isCodOrder: (widget.order.paymentMethod == Common.COD),
        context: context,
      );

      _toggleLoading();

      Common.pushAndRemoveUntil(context, Dashboard());
    }
  }
}

class RowHolder extends StatelessWidget {
  final String title, value;
  final Color? titleColor, valueColor;
  final double? titleSize, valueSize;
  const RowHolder({
    Key? key,
    required this.title,
    required this.value,
    this.titleColor,
    this.valueColor,
    this.titleSize,
    this.valueSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title",
          style: GoogleFonts.montserrat(
            fontSize: titleSize ?? 20.0,
            color: titleColor ?? AppColors.appBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "$value",
          style: GoogleFonts.montserrat(
            fontSize: valueSize ?? 17.0,
            color: valueColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
