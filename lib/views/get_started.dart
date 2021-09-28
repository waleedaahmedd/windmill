import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // for header including app icon, name and little description
              Container(
                child: Column(
                  children: [
                    Image.asset("assets/images/temp_image.png"),
                    Text("WINDMILL"),
                    const SizedBox(height: 5.0),
                    Text(
                      "Shop local stores for beverages Free delivery on the same day",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // for register or login buttons / social logins
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Center(
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.6,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFE74D4B),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Center(
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.6,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "-or register with-",
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
