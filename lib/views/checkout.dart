import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/modals/payment_modal.dart';
import 'package:windmill_general_trading/views/utils/api_requests/sms_request.dart';
import 'package:windmill_general_trading/views/utils/current_date_time.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

class Checkout extends StatefulWidget {
  final double subTotal;
  final ShoppingCartModal shoppingCart;
  const Checkout({
    Key? key,
    required this.subTotal,
    required this.shoppingCart,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController _fNameController = new TextEditingController();
  TextEditingController _lNameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailAddressController = new TextEditingController();
  TextEditingController _streetAddressController = new TextEditingController();
  TextEditingController _orderNotesController = new TextEditingController();

  UserModal? _user;
  String? _userID;
  bool _isLoading = true;
  bool _acceptedTermsAndConditions = true;

  @override
  void initState() {
    _getUserDetails();
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  void _toggleLoading({bool? isLoading}) {
    _isLoading = isLoading ?? !_isLoading;
    if (mounted) setState(() {});
  }

  void _getUserDetails() async {
    int _id = await getInt(Common.ID);
    _userID = _id.toString();
    _user = await ApiRequests.getUser(_userID!);
    if (_user != null) {
      _fNameController.text = _user!.firstName;
      _lNameController.text = _user!.lastName;
      _emailAddressController.text = _user!.email;
    }

    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WindmillAppBar(
                  title: "Checkout",
                  needBackIcon: true,
                  appBarColor: AppColors.appBlueColor,
                  titleTS: TextStyle(
                    fontSize: 22.0,
                    color: AppColors.appWhiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.appBlackColor.withOpacity(0.10),
                        offset: Offset(1, 2),
                        spreadRadius: 6.0,
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Shipping Address Information",
                        style: TextStyle(
                          color: AppColors.appBlackColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      LabelAndInputField(
                        fieldController: _fNameController,
                        label: "First Name*",
                        labelColor: AppColors.appGreyColor,
                        textColor: AppColors.appBlackColor,
                        fieldHeight: 50.0,
                      ),
                      const SizedBox(height: 10.0),
                      LabelAndInputField(
                        fieldController: _lNameController,
                        label: "Last Name*",
                        labelColor: AppColors.appGreyColor,
                        textColor: AppColors.appBlackColor,
                        fieldHeight: 50.0,
                      ),
                      const SizedBox(height: 10.0),
                      LabelAndInputField(
                        fieldController: _phoneController,
                        label: "Phone Number*",
                        inputType: TextInputType.number,
                        labelColor: AppColors.appGreyColor,
                        textColor: AppColors.appBlackColor,
                        fieldHeight: 50.0,
                      ),
                      const SizedBox(height: 10.0),
                      LabelAndInputField(
                        fieldController: _emailAddressController,
                        label: "Email-Address*",
                        inputType: TextInputType.emailAddress,
                        labelColor: AppColors.appGreyColor,
                        textColor: AppColors.appBlackColor,
                        fieldHeight: 50.0,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Country/Region:",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.appBlackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "United Arab Emirates",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.appBlueColor,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      LabelAndInputField(
                        fieldController: _streetAddressController,
                        label: "House number & Street Address*",
                        labelColor: AppColors.appGreyColor,
                        textColor: AppColors.appBlackColor,
                        fieldHeight: 50.0,
                      ),
                      const SizedBox(height: 10.0),
                      // add emirate as abu dhabi in text
                      Text(
                        "Emirate:",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.appBlackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "Abu Dhabi",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.appBlueColor,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      LabelAndInputField(
                        fieldController: _orderNotesController,
                        label: "Special notes for delivery",
                        labelColor: AppColors.appGreyColor,
                        textColor: AppColors.appBlackColor,
                        fieldHeight: 50.0,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Your personal data will be used to process your order, support your experience throughout application, and for other purposes described in our privacy policy.",
                        style: TextStyle(
                          color: AppColors.appGreyColor,
                          fontSize: 11.0,
                        ),
                      ),
                      CheckboxListTile(
                        value: _acceptedTermsAndConditions,
                        onChanged: (value) {
                          _acceptedTermsAndConditions = value!;
                          setState(() {});
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "I have read and agree to terms and conditions",
                          style: TextStyle(
                            color: AppColors.appBlackColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      PrimaryButton(
                        title: "Place Order",
                        onPressed: () => _processOrder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _isLoading ? LoadingOverlay() : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _processOrder() async {
    String _firstName = _fNameController.text.trim();
    String _lastName = _lNameController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    String _emailAddress = _emailAddressController.text.trim();
    String _houseNumberAddress = _streetAddressController.text.trim();
    String _orderNotes = _orderNotesController.text.trim();

    if (!_acceptedTermsAndConditions)
      Common.showErrorTopSnack(
          context, "Accept terms and conditions to proceed with order");
    else if (_firstName.isEmpty)
      Common.showErrorTopSnack(context, "Fill first name and proceed");
    else if (_lastName.isEmpty)
      Common.showErrorTopSnack(context, "Fill last name and proceed");
    else if (_phoneNumber.isEmpty)
      Common.showErrorTopSnack(context, "Fill phone number and proceed");
    else if (_emailAddress.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_emailAddress))
      Common.showErrorTopSnack(context, "Fill valid Email-Address and proceed");
    else if (_houseNumberAddress.isEmpty)
      Common.showErrorTopSnack(context, "Fill house number and street address");
    else {
      if (!_isLoading) {
        _toggleLoading();
        // place order to woocommerce api.
        Ing _billing = new Ing(
          firstName: _firstName,
          lastName: _lastName,
          address1: _houseNumberAddress,
          address2: _houseNumberAddress,
          city: "Abu Dhabi",
          state: "Abu Dhabi",
          postcode: "51133",
          country: "United Arab Emirates",
          email: _emailAddress,
          phone: _phoneNumber,
        );
        Ing _shipping = new Ing(
          firstName: _firstName,
          lastName: _lastName,
          address1: _houseNumberAddress,
          address2: _houseNumberAddress,
          city: "Abu Dhabi",
          state: "Abu Dhabi",
          postcode: "51133",
          country: "United Arab Emirates",
          email: _emailAddress,
          phone: _phoneNumber,
        );
        List<LineItem> _lineItems = [];
        widget.shoppingCart.products.forEach((product) {
          LineItem _item = new LineItem(
            productId: int.parse(product.productId),
            variationId: product.productVariation,
            quantity: product.productQuantity,
          );
          _lineItems.add(_item);
        });
        List<ShippingLine> _shippingLine = [];
        OrderModal _order = new OrderModal(
          customerID: _userID!,
          note: _orderNotes,
          orderStatus: "processing",
          paymentMethod: "Online Payment",
          paymentMethodTitle: "Online Payment Through Ngenious",
          setPaid: false,
          billing: _billing,
          shipping: _shipping,
          lineItems: _lineItems,
          shippingLines: _shippingLine,
        );
        PaymentModal dataOrder =
            await ApiRequests().createOrder(widget.subTotal, _order);
        if (dataOrder.paymentUrl != null) {
          showModalBottomSheet<void>(
            // context and builder are
            // required properties in this widget

            isScrollControlled: true,

            context: context,
            builder: (BuildContext context) {
              // we set up a container inside which
              // we create center column and display text
              return Padding(
                padding: EdgeInsets.only(top: 40),
                child: WillPopScope(
                  onWillPop: () async {
                    bool orderFlag =
                        await ApiRequests().monitorOrder(dataOrder);
                    if (orderFlag == true) {
                      await ApiRequests.placeOrder(_order);
                      // remove user shopping cart from fire-store
                      await ApiRequests.deleteUserShoppingCart(_userID!);

                      Common.showSuccessTopSnack(context,
                          "Order placed successfully. Thank you for shopping with us.");
                      String message =
                          "Dear Web EDS, Thank you. We've received your Order\nOn: ${CurrentDateTime().getDate()}\nShipping: Free shipping\nPayment method: N-Genius Online Payment Gateway\nTotal Bill : AED 290\nOrder No. #11713\nFor more details click the link below: https://demo.windmillcellar.com/my-account/view-order/11713/";
                       SmsRequest().sendSMSOrderCompletion(_order,message);

                      _toggleLoading();

                      Common.pushAndRemoveUntil(context, Dashboard());
                    } else {
                      Common.showSuccessTopSnack(
                          context, "Failed to monitor order");
                    }
                    print("asdf");
                    _toggleLoading();

                    return Future.value(true);
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Payment Method'),
                      backgroundColor: AppColors.appBlueColor,
                    ),
                    body: Wrap(
                      children: [
                        Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height - 100,
                            child: WebView(
                              gestureRecognizers: gestureRecognizers,
                              initialUrl: dataOrder.paymentUrl,
                              javascriptMode: JavascriptMode.unrestricted,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          Common.showSuccessTopSnack(context, "Something went wrong!!");
        }
      }
    }
  }

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();
}
