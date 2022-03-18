import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/routes/app_routes.dart';
import 'package:windmill_general_trading/views/utils/common.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "${Common.assetsImages}headlogo.png",
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Choose a type of shopping',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Click & Collect',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Ghantoot Branch Only',
                                    style: TextStyle(color: Colors.white,fontSize: 12),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Free Delivery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Abu Dhabi and Al Ain Only',
                                    style: TextStyle(color: Colors.white,fontSize: 12),
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  title: Text(
                    "Remember me",
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                CheckboxListTile(
                  title: RichText(
                    text: TextSpan(
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'I agree to ',
                            style: TextStyle(color: Colors.grey)),
                        new TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'Terms & Condition ',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                        new TextSpan(
                            text: 'Apply',
                            style: new TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you over 21 years of age?",
                  style: TextStyle(color: Colors.grey,fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context)
                                .pushNamed(AppRoutes.getStartedRoute);
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10.0),
                                ),),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(color: Colors.white,fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),  
                    Expanded(
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: new BorderRadius.all(
                              Radius.circular(10.0),
                            ),),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
