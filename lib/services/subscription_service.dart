import 'package:intl/intl.dart';

class SubscriptionService {
  DateTime calculateNextPaymentDate(DateTime subscriptionDate) {
    DateTime today = DateTime.now();
    DateTime nextPaymentDate;

    if (today.month == 12 && today.day > subscriptionDate.day) {
      nextPaymentDate = DateTime(today.year + 1, 1, subscriptionDate.day);
    } else if (today.day > subscriptionDate.day) {
      nextPaymentDate = DateTime(today.year, today.month + 1, subscriptionDate.day);
    } else {
      nextPaymentDate = DateTime(today.year, today.month, subscriptionDate.day);
    }

    return nextPaymentDate;
  }

  int calculateDaysLeft(DateTime subscriptionDate) {
    DateTime nextPaymentDate = calculateNextPaymentDate(subscriptionDate);
    int daysLeft = nextPaymentDate.difference(DateTime.now()).inDays;
    return daysLeft;
  }

  String getFormattedDate(DateTime subscriptionDate) {
    DateTime nextPaymentDate = calculateNextPaymentDate(subscriptionDate);
    int daysLeft = calculateDaysLeft(subscriptionDate);

    return "${DateFormat('MMMM').format(nextPaymentDate)} ${DateFormat('dd').format(nextPaymentDate)} - ${daysLeft == 0 ? "Today" : "${daysLeft == 0 ? "Today" : daysLeft} day${daysLeft == 1 ? '' : 's'} left"}";
  }
}
