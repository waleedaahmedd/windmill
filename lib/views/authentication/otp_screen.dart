import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:windmill_general_trading/modals/shopping_cart_modal.dart';
import 'package:windmill_general_trading/views/utils/api_requests/api_requests.dart';
import 'package:windmill_general_trading/views/utils/app_colors.dart';

import '../../modals/create_verify_otp_model.dart';
import '../../modals/order_modal.dart';
import '../../modals/payment_modal.dart';
import '../dashboard.dart';
import '../utils/common.dart';
import '../utils/shared_pref.dart';
import '../utils/widgets/loading_overlay.dart';

class OtpScreen extends StatefulWidget {
  final String? phone;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? comingFrom;
  final String? address;
  final ShoppingCartModal? shoppingCart;
  final String? userId;
  final String? note;
  final double? total;

  const OtpScreen({
    Key? key,
    this.phone,
    this.password,
    this.email,
    this.lastName,
    this.firstName, this.comingFrom, this.address, this.shoppingCart, this.userId, this.note, this.total,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  CreateAndVerifyOtpModel? _createAndVerifyOtpData;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /* const SizedBox(height: 30),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(Constants.otpGifImage),
                      ),
                    ),*/
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Phone Number Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: RichText(
                        text: TextSpan(
                            text: "Enter the code sent to ",
                            children: [
                              TextSpan(
                                  text: "${widget.phone}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                            appContext: context,
                            /* pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),*/
                            length: 6,
                            //obscureText: true,
                            // obscuringCharacter: '*',
                            /*  obscuringWidget: const FlutterLogo(
                              size: 24,
                            ),*/
                            //  blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 6) {
                                return "Wrong Otp";
                              } else {
                                return "Valid";
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: AppColors.appBlueColor,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            //enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? "*Please fill up all the cells properly"
                            : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            _resendOtp();
                          },
                          child: const Text(
                            "RESEND",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            formKey.currentState!.validate();
                            // conditions for validating
                            if (currentText.length != 6 /*||
                                currentText != "123456"*/) {
                              errorController!.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() => hasError = true);
                            } else {
                              setState(
                                () {
                                  hasError = false;
                                  _checkVerification();
                                //  snackBar("OTP Verified!!");
                                },
                              );
                            }
                          },
                          child: Center(
                              child: Text(
                            "VERIFY".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.appBlueColor,
                        borderRadius: BorderRadius.circular(5),
                        /*  boxShadow: [
                            BoxShadow(
                                color: AppColors.appBlueColor,
                                offset: const Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: AppColors.appBlueColor,
                                offset: const Offset(-1, 2),
                                blurRadius: 5)
                          ]*/
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            child: TextButton(
                              child: const Text("Clear"),
                              onPressed: () {
                                textEditingController.clear();
                              },
                            )),
                        Flexible(
                            child: TextButton(
                              child: const Text("Set Text"),
                              onPressed: () {
                                setState(() {
                                  textEditingController.text = "123456";
                                });
                              },
                            )),
                      ],
                    )*/
                  ],
                ),
                _isLoading ? LoadingOverlay() : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isLoading = true;
    });

    _createAndVerifyOtpData = await ApiRequests.createOrVerifyOtp(
        context, widget.phone!);

    print(_createAndVerifyOtpData!.status);

    snackBar("${_createAndVerifyOtpData!.status}");

    setState(() {
      _isLoading = false;
    });

    /*if (_createAndVerifyOtpData!.status == 'already_verified') {
      _processRegistration();
    } else {
      setState(() {
        _isLoading = false;
      });
      snackBar("Wrong Otp");
    }*/
  }

  Future<void> _checkVerification() async {
    setState(() {
      _isLoading = true;
    });

    _createAndVerifyOtpData = await ApiRequests.verifyOtp(
        context, widget.phone!, textEditingController.text);

    print(_createAndVerifyOtpData!.status);

    if (_createAndVerifyOtpData!.status == 'already_verified') {
      if(widget.comingFrom == 'login'){
        _processLogin();
      }
      else if(widget.comingFrom == 'register'){
        _processRegistration();
      }
      else{
        _processOrder();
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      snackBar("Wrong Otp");
    }
  }

  void _processRegistration() async {
    var request = {
      'email': widget.email,
      'first_name': widget.firstName,
      'last_name': widget.lastName,
      'username': widget.phone,
      'password': widget.password,
    };

    await ApiRequests.registerUser(context, request)
        .then((registeredUser) async {
      if (registeredUser.id == null) {
        setState(() {
          _isLoading = false;
        });
        Common.showErrorTopSnack(
          context,
          "${registeredUser.message}",
        );
      } else {
        _processLogin();
      }
    }).onError(
          (error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        Common.showErrorTopSnack(
          context,
          "$error",
        );
      },
    );
  }

  void _processLogin() async {
    _isLoading = true;
    setState(() {});
    await ApiRequests.loginUser(context, widget.email!, uid: widget.password!)
        .then((value) async {
      setState(() {
        _isLoading = false;
      });

      if (value.success) {
        // store token in shared preferences
        setString(Common.TOKEN, value.data!.token);
        setInt(Common.ID, value.data!.id);
        Common.pushAndRemoveUntil(context, Dashboard());
      } else {
        Common.showErrorTopSnack(
          context,
          "${value.message}",
        );
      }
    }).onError(
      (error, stackTrace) {
        print("Dio Error --------" + error.toString());

        setState(() {
          _isLoading = false;
        });
        Common.showErrorTopSnack(
          context,
          "Unable to login. please try again by double checking your email-address and password.",
        );
      },
    );
  }

  void _processOrder() async {


    if (!_isLoading) {
      // place order to woocommerce api.
      Ing _billing = new Ing(
        firstName: widget.firstName!,
        lastName: widget.lastName!,
        address1: widget.address!,
        address2: widget.address!,
        city: "Abu Dhabi",
        state: "Abu Dhabi",
        postcode: "51133",
        country: "United Arab Emirates",
        email: widget.email!,
        phone: widget.phone!,
      );
      Ing _shipping = new Ing(
        firstName: widget.firstName!,
        lastName: widget.lastName!,
        address1: widget.address!,
        address2: widget.address!,
        city: "Abu Dhabi",
        state: "Abu Dhabi",
        postcode: "51133",
        country: "United Arab Emirates",
        email: widget.email!,
        phone: widget.phone!,
      );
      List<LineItem> _lineItems = [];
      widget.shoppingCart!.products.forEach((product) {
        LineItem _item = new LineItem(
          productId: int.parse(product.productId),
          variationId: product.productVariation,
          quantity: product.productQuantity,
        );
        _lineItems.add(_item);
      });
      List<ShippingLine> _shippingLine = [];
      OrderModal _order = new OrderModal(
        customerID: widget.userId!,
        note: widget.note!,
        // orderStatus: "N-Genius Online Complete",
        orderStatus: "N-Genius Online Complete",
        paymentMethod: "Online Payment",
        paymentMethodTitle: "Online Payment Through Ngenious",
        setPaid: false,
        billing: _billing,
        shipping: _shipping,
        lineItems: _lineItems,
        shippingLines: _shippingLine,
      );
      PaymentModal dataOrder =
      await ApiRequests().createOrder(widget.total!, _order);
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
                  // await ApiRequests.placeOrder(_order);
                  _completeOrder(_order, dataOrder);
                  return Future.value(true);
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Payment Method',),
                    backgroundColor: AppColors.appBlueColor,
                  ),
                  body: Wrap(
                    children: [
                      Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height - 100,
                          child: WebView(
                            navigationDelegate: (request) async {
                              if (request.url.contains(Common.REDIRECT_URL)) {
                                print("I am inside");
                                await _completeOrder(_order, dataOrder);
// Close current window
                                return NavigationDecision
                                    .prevent; // Prevent opening url
                              } else {
                                return NavigationDecision
                                    .navigate; // Default decision
                              }
                            },
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

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  Future<void> _completeOrder(_order, dataOrder) async {
    await ApiRequests.placeOrder(_order);
    //
    // print("I am in complete order");
    // bool orderFlag = await ApiRequests().monitorOrder(dataOrder);
    // if (orderFlag == true) {
    //   await ApiRequests.placeOrder(_order);
    //   // remove user shopping cart from fire-store
    //   await ApiRequests.deleteUserShoppingCart(_userID!);
    //
    //   Common.showSuccessTopSnack(context,
    //       "Order placed successfully. Thank you for shopping with us.");
    //   String message =
    //       "Dear Web EDS, Thank you. We've received your Order\nOn: ${CurrentDateTime().getDate()}\nShipping: Free shipping\nPayment method: N-Genius Online Payment Gateway\nTotal Bill : AED 290\nOrder No. #11713\nFor more details click the link below: https://demo.windmillcellar.com/my-account/view-order/11713/";
    //   SmsRequest().sendSMSOrderCompletion(_order, message);
    //
    //   _toggleLoading();
    //
    //   Common.pushAndRemoveUntil(context, Dashboard());
    // } else {
    //   Common.showSuccessTopSnack(context, "Transaction Declined");
    // }
    // print("asdf");
    // _toggleLoading();
  }
}
