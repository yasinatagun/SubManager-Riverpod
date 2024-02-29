import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/constants/colors.dart';
import 'package:subscription_manager/models/chart_data.dart';
import 'package:subscription_manager/models/subscription.dart';
import 'package:subscription_manager/riverpod/chart_notifier.dart';
import 'package:subscription_manager/riverpod/sub_list_notifier.dart';
import 'package:subscription_manager/screens/select_firm.dart';
import 'package:subscription_manager/services/locator.dart';
import 'package:subscription_manager/services/subscription_service.dart';
import 'package:subscription_manager/services/user_service.dart';
import 'package:subscription_manager/widgets/greeting_widget.dart';
import 'package:subscription_manager/widgets/user_name_display.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final subscriptionService = locator<SubscriptionService>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* Riverpoda bağlı bir liste budur.
    List<Subscription> subscriptionsList = ref.watch(subscriptionListProvider);
    final chartData = ref.watch(chartNotifierProvider);
    final totalAmount = ref.watch(totalAmountProvider);

    return Scaffold(
      backgroundColor: greyBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),
              UserNameDisplay(),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              color: Colors.amber,
              style: IconButton.styleFrom(
                backgroundColor: greyBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                String userEmail = locator<UserManager>().getUserEmail();
                log(userEmail);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectFirm(),
                    )).then((value) {
                  if (value != null) {
                    ref
                        .read(subscriptionListProvider.notifier)
                        .addSubscription(userEmail, value);
                  }
                });
              },
              icon: const Icon(
                Icons.add,
                color: blackMain,
              ),
            ),
          ),
        ],
      ),
      //* BODY STARTS
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //* CHART
                        child: SfCircularChart(
                          series: <CircularSeries<ChartData, String>>[
                            PieSeries<ChartData, String>(
                                dataSource: chartData,
                                legendIconType: LegendIconType.circle,
                                xValueMapper: (ChartData data, _) => data.name,
                                yValueMapper: (ChartData data, _) =>
                                    data.amount,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color, // Map color from data

                                name: 'Gold')
                          ],
                          legend: const Legend(
                            isVisible: false,
                          ),
                        ),
                        //* CHART FINISH
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$totalAmount TL",
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5),
                          ),
                          const Text(
                            "Amount",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class PieData {
  PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
