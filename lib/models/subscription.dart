import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subscription_manager/models/category.dart';
import 'package:subscription_manager/models/payment_type.dart';
import 'package:subscription_manager/models/subscription_firm.dart';

class Subscription {
  static int _nextId = 0;

  final int id;
  final SubscriptionFirm subscriptionFirm;
  final Category subscriptionCategory;
  final DateTime subscriptionDay;
  final double price;
  final PaymentType paymentType;

  Subscription({
    int? id,
    required this.subscriptionFirm,
    required this.subscriptionCategory,
    required this.subscriptionDay,
    required this.price,
    required this.paymentType,
  }) : id = id ?? _generateNextId();

  static int _generateNextId() {
    return _nextId++;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subscriptionFirm': subscriptionFirm.toMap(),
      'subscriptionCategory': subscriptionCategory.toMap(),
      'subscriptionDay': Timestamp.fromDate(subscriptionDay),
      'price': price,
      'paymentType': paymentTypeToInt(paymentType), 
    };
  }

  static Subscription fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      subscriptionFirm: SubscriptionFirm.fromMap(map['subscriptionFirm']),
      subscriptionCategory: Category.fromMap(map['subscriptionCategory']),
      subscriptionDay: (map['subscriptionDay'] as Timestamp).toDate(),
      price: map['price'],
      paymentType: intToPaymentType(map['paymentType']), 
    );
  }
}
