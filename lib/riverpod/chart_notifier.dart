import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/data/premade_firms.dart';
import 'package:subscription_manager/models/category.dart';
import 'package:subscription_manager/models/chart_data.dart';
import 'package:subscription_manager/riverpod/sub_list_notifier.dart';

class ChartNotifier extends StateNotifier<List<ChartData>> {
  ChartNotifier(this.ref) : super([]);
  final Ref ref;

  void updateChartData() {
    final subscriptions = ref.watch(subscriptionListProvider);
    final Map<String, double> categoryTotals = {};

    for (var subscription in subscriptions) {
      final categoryName = subscription.subscriptionCategory.categoryName;
      final price = subscription.price;
      categoryTotals.update(
          categoryName, (currentTotal) => currentTotal + price,
          ifAbsent: () => price);
    }

    List<ChartData> newData = categoryTotals.entries.map((entry) {
      final category = categories.entries
          .firstWhere((cat) => cat.value.categoryName == entry.key,
              orElse: () => MapEntry(categories.entries.first.key,
                  Category(categoryName: "Unknown", color: Colors.grey)))
          .value;

      return ChartData(entry.key, entry.value, category.color);
    }).toList();

    state = newData;
  }
}

final chartNotifierProvider =
    StateNotifierProvider<ChartNotifier, List<ChartData>>((ref) {
  return ChartNotifier(ref)..updateChartData();
});

final totalAmountProvider = Provider<double>((ref) {
  final chartData = ref.watch(chartNotifierProvider);
  return chartData.fold(
      0, (previousValue, element) => previousValue + element.amount);
});
