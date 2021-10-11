import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    child: Image.asset(
                      '${Common.assetsImages}demo_product.png',
                      fit: BoxFit.fill,
                      height: 350.0,
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appGreyColor.withOpacity(0.4),
                              blurRadius: 5.0,
                              spreadRadius: 5.0,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.appWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Royal Salute 21 Years Old',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30.0,
                              height: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.appGreyColor.withOpacity(0.3),
                                offset: Offset(1, 2),
                                spreadRadius: 5.0,
                                blurRadius: 12.0,
                              ),
                            ],
                          ),
                          child: Icon(
                            CupertinoIcons.heart,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 30.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black26,
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5,
                              horizontal: 18.0,
                            ),
                            margin: const EdgeInsets.only(right: 5.0),
                            child: Center(
                              child: Text(
                                '70cl',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: AppColors.appBlueColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                CupertinoIcons.minus,
                                size: 16.0,
                                color: Colors.white,
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              Icon(
                                Icons.add,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            '\$450',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MontserratBlack',
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'One of the jewels in the Chivas crown Royal-Salute is a very special long-aged bless',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.appWhiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.appGreyColor.withOpacity(0.2),
              offset: Offset(1, 2),
              spreadRadius: 10.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CONTINUE EXPLORING',
                style: TextStyle(
                  color: AppColors.appBlueColor,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'MontserratBlack',
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    color: AppColors.appWhiteColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'MontserratBlack',
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
