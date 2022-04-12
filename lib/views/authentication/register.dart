import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:windmill_general_trading/modals/create_verify_otp_model.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import '../routes/app_routes.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _uidController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  String? _email;
  String? _uid;
  String? _fName;
  String? _lName;
  String? _phoneNumber;
  CreateAndVerifyOtpModel? _createAndVerifyOtpData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "${Common.assetsImages}background.jpg",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
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
                        "Create\nAccount",
                        style: GoogleFonts.montserrat(
                          color: AppColors.appWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      LabelAndInputField(
                        fieldController: _firstNameController,
                        label: 'First Name',
                      ),
                      const SizedBox(height: 15.0),
                      LabelAndInputField(
                        fieldController: _lastNameController,
                        label: 'Last Name',
                      ),
                      const SizedBox(height: 15.0),
                      LabelAndInputField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('+971',style: GoogleFonts.montserrat(color: AppColors.appWhiteColor),),
                        ),
                        fieldController: _phoneNumberController,
                        label: 'PhoneNumber',
                      ),
                      const SizedBox(height: 15.0),
                      LabelAndInputField(
                        fieldController: _emailController,
                        label: 'Email Address',
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15.0),
                      LabelAndInputField(
                        fieldController: _uidController,
                        label: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0),
                      PrimaryButton(
                        title: "REGISTER",
                        onPressed: () => _checkValidation(),
                      ),
                      const SizedBox(height: 20.0),
                      ContinueWithAndSocialAuthSection(
                        googleOnPressed: () async {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _isLoading ? LoadingOverlay() : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _checkValidation() {
    setState(() {
      _email = _emailController.text.trim();
      _uid = _uidController.text.trim();
      _fName = _firstNameController.text.trim();
      _lName = _lastNameController.text.trim();
      _phoneNumber = '971${_phoneNumberController.text.trim()}';
    });

    if (_fName!.isEmpty)
      Common.showErrorTopSnack(context, "First name is required to proceed.");
    else if (_lName!.isEmpty)
      Common.showErrorTopSnack(context, "Last name is required to proceed.");
    else if (_email!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_email!))
      Common.showErrorTopSnack(
          context, "Valid email-address is required to proceed.");
    else if (_uid!.isEmpty || _uid!.length < 8)
      Common.showErrorTopSnack(context,
          "Strong password minimum of 8 characters is required to proceed.");
    else if (_phoneNumber!.isEmpty || !RegExp(r'(^(?:9)?[0-9]{10,12}$)')
        .hasMatch(_email!))
      Common.showErrorTopSnack(context,
          "phone Number is not valid");
    else {
      _checkVerification();
    }
  }

  Future<void> _checkVerification() async {

    setState(() {
      _isLoading = true;
    });

    _createAndVerifyOtpData = await ApiRequests.createOrVerifyOtp(context, _phoneNumber!);

    print(_createAndVerifyOtpData!.status);

    if(_createAndVerifyOtpData!.status == 'already_verified') {
      _processRegistration();
    }
    else{
      Navigator.of(context).pushNamed(
        AppRoutes.registerRoute,
      );
    }
  }

  void _processRegistration() async {
        var request = {
      'email': _email,
      'first_name': _fName,
      'last_name': _lName,
      'username': _phoneNumber,
      'password': _uid,
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
        await ApiRequests.loginUser(context, _email!, uid: _uid)
            .then((loggedUser) async {
          setState(() {
            _isLoading = false;
          });
          setString(Common.TOKEN, loggedUser.data!.token);
          setInt(Common.ID, loggedUser.data!.id);
          Common.pushAndRemoveUntil(context, Dashboard());
        });
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
}
