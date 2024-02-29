import 'package:flutter/material.dart';
import 'package:subscription_manager/constants/colors.dart';
import 'package:subscription_manager/data/premade_firms.dart';
import 'package:subscription_manager/models/category.dart';
import 'package:subscription_manager/models/payment_type.dart';
import 'package:subscription_manager/models/subscription.dart';
import 'package:subscription_manager/models/subscription_firm.dart';
import 'package:subscription_manager/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key, required this.subscriptionFirm});
  final SubscriptionFirm subscriptionFirm;
  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final subPriceController = TextEditingController();
  final dateController = TextEditingController();
  var selectedCategory = categories[Categories.business]!;
  var selectedPaymentType = PaymentType.cash;
  DateTime? selectedTime;
  double selectedPrice = 0.0;
  late SubscriptionFirm subscriptionFirm;

  Future<void> selectDate() async {
    selectedTime = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());

    if (selectedTime != null) {
      dateController.text = selectedTime.toString().split(" ")[0];
    }
  }

  @override
  void initState() {
    super.initState();
    subscriptionFirm = widget.subscriptionFirm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(
                          subscriptionFirm.imageUrl,
                          width: 80,
                        ),
                      ),
                      Text(
                        subscriptionFirm.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subscriptionFirm.category.categoryName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: subPriceController,
                hintText: "eg: 30 or 30.05",
                inputType: TextInputType.datetime,
                title: "Subscription Price",
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Payment Date",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        TextField(
                          controller: dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Date Picker",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onTap: () {
                            selectDate();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Payment Type",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          value: selectedPaymentType.name,
                          items: PaymentType.values.map((paymentType) {
                            return DropdownMenuItem(
                              value: paymentType.name,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: Colors
                                        .blue, // Consider customizing this color as needed
                                  ),
                                  const SizedBox(width: 6),
                                  Text(paymentType.name),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              if (value != null) {
                                selectedPaymentType = PaymentType.values
                                    .firstWhere((e) => e.name == value);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // HERERERERE
                  selectedPrice = subPriceController.text.isEmpty
                      ? 0.0
                      : double.parse(subPriceController.text);
                  Navigator.pop(
                      context,
                      //* BURADA SUBSCRIPTONU GÖNDERİYORUZ.
                      Subscription(
                          subscriptionFirm: subscriptionFirm,
                          subscriptionCategory: subscriptionFirm.category,
                          subscriptionDay: selectedTime!,
                          price: selectedPrice,
                          paymentType: selectedPaymentType));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text("Save Subscription"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
