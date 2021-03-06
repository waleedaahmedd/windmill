import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import '../../cart_provider.dart';
import '../../modals/create_verify_otp_model.dart';
import 'otp_screen.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  CreateAndVerifyOtpModel? _createAndVerifyOtpData;
  String? email;
  String? uid;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "${Common.assetsImages}background.jpg",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "${Common.assetsImages}application_icon.png",
                          width: 60.0,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "Welcome\nBack",
                      style: GoogleFonts.montserrat(
                        color: AppColors.appWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    LabelAndInputField(
                      fieldController: emailController,
                      label: 'Email Address / Phone Number',
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15.0),
                    LabelAndInputField(
                      fieldController: uidController,
                      label: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    // TODO: change route to option choice screen later
                    PrimaryButton(
                      title: "LOGIN",
                      onPressed: () => _checkValidation(),
                    ),
                    const SizedBox(height: 10.0),
                    InquiryTextButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        AppRoutes.registerRoute,
                      ),
                    ),
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

  void _checkValidation() async {
    email = emailController.text.trim();
    uid = uidController.text.trim();
    if (email!.isEmpty /*||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email!) ||
        !RegExp(r'(^(?:9)?[0-9]{10,12}$)').hasMatch(email!)*/)
      Common.showErrorTopSnack(
          context, "Please provide valid Email-Address and try again");
    else if (uid!.isEmpty)
      Common.showErrorTopSnack(
          context, "Please provide strong password and try-again");
    else {
      if (email! == RegExp(r'(^(?:9)?[0-9]{10,12}$)')) {
        _checkVerification();
      } else {
        _processLogin();
      }
    }
  }

  Future<void> _checkVerification() async {
    setState(() {
      _isLoading = true;
    });

    _createAndVerifyOtpData =
        await ApiRequests.createOrVerifyOtp(context, email!);

    print(_createAndVerifyOtpData!.status);

    if (_createAndVerifyOtpData!.status == 'already_verified') {
      _processLogin();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OtpScreen(phone: email, password: uid, comingFrom: 'login')),
      );
    }
  }

  void _processLogin() async {
    _isLoading = true;
    setState(() {});
    await ApiRequests.loginUser(context, email!, uid: uid!).then((value) async {
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
}
