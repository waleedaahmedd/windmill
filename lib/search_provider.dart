import 'package:flutter/cupertino.dart';
import 'package:windmill_general_trading/modals/modals_exporter.dart';
import 'package:windmill_general_trading/views/utils/api_requests/api_requests.dart';

class SearchProductProvider with ChangeNotifier {
  List<ProductModal> productList = [];
  bool searchLoading = false;

  /*get getProductList {
    return this.productList;
  }*/

  setProductList(List<ProductModal> value) {
    this.productList = value;
    setSearchLoading(false);
    notifyListeners();
  }

  clearProductList(){
    this.productList.clear();
    setSearchLoading(false);
    notifyListeners();
  }

  setSearchLoading(bool value) {
    this.searchLoading = value;
    notifyListeners();
  }

  Future<void> getProducts(String value) async {
    setSearchLoading(true);
    final getProductList = await ApiRequests.getProductByType('search=$value', 10, 1);
    setProductList(getProductList);
    print(productList);
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
