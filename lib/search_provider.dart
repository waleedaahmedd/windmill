import 'package:flutter/cupertino.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';

class SearchProductProvider with ChangeNotifier {
  List<ProductModal> _productList = [];

  get getProductList {
    return this._productList;
  }
 /* addCartCount(String count) {
    this._productList = count;
    notifyListeners();
  }*/

/* Future<dynamic> callOTP(String number) async {
    var response = await http!.sendOTP(number);
    if (response == 'OK') {
      //navigationService.closeScreen();
      return navigationService.navigateTo(OtpScreenRoute);
    } else {
      //navigationService.closeScreen();
      return utilsService.showToast('Please Check Phone Number');
    }
  }
*/

}
