import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/constants/colors.dart';
import 'package:subscription_manager/models/subscription.dart';
import 'package:subscription_manager/riverpod/sub_list_notifier.dart';
import 'package:subscription_manager/services/locator.dart';
import 'package:subscription_manager/services/subscription_service.dart';
import 'package:subscription_manager/widgets/greeting_widget.dart';
import 'package:subscription_manager/widgets/user_name_display.dart';

class SubListScreen extends ConsumerWidget {
  final subscriptionService = locator<SubscriptionService>();

  final double totalAmount = 0;

  SubListScreen({super.key});

  DateTime calculateNextPaymentDate(DateTime subscriptionDate) {
    DateTime today = DateTime.now();
    DateTime nextPaymentDate =
        DateTime(today.year, today.month, subscriptionDate.day);

    if (today.day > subscriptionDate.day) {
      // If today's day is past the payment day, move to next month
      nextPaymentDate =
          DateTime(today.year, today.month + 1, subscriptionDate.day);
    }

    // Handle year transition
    if (today.month == 12 && today.day > subscriptionDate.day) {
      nextPaymentDate = DateTime(today.year + 1, 1, subscriptionDate.day);
    }

    return nextPaymentDate;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionsList = ref.watch(subscriptionListProvider);

    return Scaffold(
      backgroundColor: greyBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),
              UserNameDisplay(),
            ],
          ),
        ),
      ),
      //* BODY STARTS
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              const Text(
                "Active Subscriptions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: subscriptionsList.length,
                  itemBuilder: (context, index) {
                    Subscription subscription = subscriptionsList[index];
                    String formattedDate = subscriptionService
                        .getFormattedDate(subscription.subscriptionDay);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Image.asset(
                                      subscriptionsList[index]
                                          .subscriptionFirm
                                          .imageUrl,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subscriptionsList[index]
                                            .subscriptionFirm
                                            .name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(formattedDate,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${subscriptionsList[index].price} \$",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const Text(
                                    "Monthly",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
