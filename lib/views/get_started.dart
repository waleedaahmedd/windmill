import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:windmill_general_trading/views/views_exporter.dart';

import '../modals/social_login_modal.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool _isLoading = false;

  @override
  void initState() {
    _processUserAuthCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${Common.assetsImages}background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: _isLoading
            ? LoadingOverlay()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 40.0),
                          Image.asset(
                            "${Common.assetsImages}application_icon.png",
                            height: 100.0,
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            "WINDMILL",
                            style: TextStyle(
                              color: AppColors.appWhiteColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            "Shop local stores for beverages\nFree delivery on the same day",
                            style: TextStyle(
                              color: AppColors.appWhiteColor.withOpacity(0.5),
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PrimaryButton(
                            title: "REGISTER",
                            buttonBorder: Border.all(
                              color: AppColors.appWhiteColor,
                              width: 1.5,
                            ),
                            buttonColor: Colors.transparent,
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRoutes.registerRoute),
                          ),
                          const SizedBox(height: 15.0),
                          PrimaryButton(
                            title: 'LOG IN',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRoutes.loginRoute),
                          ),
                          const SizedBox(height: 15.0),
                          ContinueWithAndSocialAuthSection(
                            googleOnPressed: () => _processGoggleLogin(),
                            fbOnPressed: () => _processFBLogin(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _processFBLogin() async {
    _isLoading = true;
    setState(() {});

    await ApiRequests.facebookLogin(context).then((loggedUser) async {
      setState(() {
        _isLoading = false;
      });
      SocialLoginModal data = loggedUser;

      if (data.id != null) {
        // store token in shared preferences
        setString(Common.TOKEN, data.token!);
        setInt(Common.ID, data.id!);
        Common.pushAndRemoveUntil(context, Dashboard());
      }
    });
  }

  void _processGoggleLogin() async {
    _isLoading = true;
    setState(() {});

    await ApiRequests.googleLogin(context).then((loggedUser) async {
      setState(() {
        _isLoading = false;
      });
      setString(Common.TOKEN, loggedUser.data!.token);
      setInt(Common.ID, loggedUser.data!.id);
      Common.pushAndRemoveUntil(context, Dashboard());
    });
  }

  Future<void> _processUserAuthCheck() async {
    bool _isUserLoggedIn = await getString(Common.TOKEN) == "" ? false : true;
    if (_isUserLoggedIn) Common.pushAndRemoveUntil(context, Dashboard());
  }
}
