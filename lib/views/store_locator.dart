import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';
import 'package:windmill_general_trading/views/utils/widgets/store_locator_box.dart';
import 'package:windmill_general_trading/views/utils/widgets/widgets_exporter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoreLocator extends StatelessWidget {
  StoreLocator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WindmillAppBar(
                appBarColor: AppColors.appBlueColor,
                needBackIcon: true,
                title: "Store Locator",
                titleTS: GoogleFonts.montserrat(
                  color: AppColors.appWhiteColor,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),
              locator(
                context,
                "Dubai – Abu Dhabi Border Ghantoot",
                [
                  StoreLocatorBox(
                    icons: Icons.location_on,
                    title: "Our Location",
                    text: "Ghantoot, Golden Tulip, Al Jazira Hotel",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.info,
                    title: "Info",
                    text: "No PCR Test and Liquor Licence Required",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: FontAwesomeIcons.globe,
                    title: "Distance",
                    text: "Just 20mins drive from Dubai",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.phone,
                    title: "Contact Us",
                    text: "+971 56 538 9582",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.mail,
                    title: "Email Us",
                    text: "info@windmillgt.com",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.access_time,
                    title: "Open Hours",
                    text: "9AM – 10PM, Daily",
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              locator(
                context,
                "Abu Dhabi – Khalifa City",
                [
                  StoreLocatorBox(
                    icons: Icons.location_on,
                    title: "Our Location",
                    text:
                        "Behind Etihad Plaza, Al Rabhia Compound, Khalifa City A",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.phone,
                    title: "Call Us",
                    text: "+971 25 560868",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.email,
                    title: "Email Us",
                    text: "info@windmillgt.com",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.access_time,
                    title: "Open Hours",
                    text: "9AM – 10PM, Daily",
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              locator(
                context,
                "Abu Dhabi – Mussafah",
                [
                  StoreLocatorBox(
                    icons: Icons.location_on,
                    title: "Our Location",
                    text: "Mussafah – 11, Abu Dhabi UAE",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.phone,
                    title: "Call Us",
                    text: "+971 25 551898",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.email,
                    title: "Email Us",
                    text: "info@windmillgt.com",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.access_time,
                    title: "Open Hours",
                    text: "9AM – 10PM, Daily",
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              locator(
                context,
                "Alain Shop",
                [
                  StoreLocatorBox(
                    icons: Icons.location_on,
                    title: "Our Location",
                    text:
                        "Behind Al Ain Rotana Zayed Bin Sultan Street, Al Ain",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.phone,
                    title: "Call Us",
                    text: "+971 56 534 7149",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.email,
                    title: "Email Us",
                    text: "info@windmillgt.com",
                  ),
                  SizedBox(height: 25.0),
                  StoreLocatorBox(
                    icons: Icons.access_time,
                    title: "Open Hours",
                    text: "9AM – 10PM, Daily",
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget locator(BuildContext context, String title, List<Widget> widget) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: const Color(0xFFe74d4b),
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.0),
        Column(
          children: widget,
        ),
      ],
    ),
  );
}
