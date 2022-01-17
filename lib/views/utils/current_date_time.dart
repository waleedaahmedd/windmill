import 'package:intl/intl.dart';

class CurrentDateTime{
  String getDate(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return formattedDate;
  }
}