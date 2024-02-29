import 'package:flutter/material.dart';
import 'package:subscription_manager/constants/colors.dart';
import 'package:subscription_manager/data/premade_firms.dart';
import 'package:subscription_manager/screens/add_subscription.dart';

class SelectFirm extends StatefulWidget {
  const SelectFirm({super.key});

  @override
  State<SelectFirm> createState() => _SelectFirmState();
}

class _SelectFirmState extends State<SelectFirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [ 
          const Text("Select which subscription you want to add", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          
          Expanded(
            child: ListView.builder(
            itemCount: subscriptionFirmList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddSubscriptionScreen(subscriptionFirm: subscriptionFirmList[index],),)).then((value){
                    if (value != null) {
                      Navigator.pop(context, value);
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: Image.asset(
                          subscriptionFirmList[index].imageUrl,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(subscriptionFirmList[index].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ]),
                  ),
                ),
              );
            },
                    ),
          ),
        ],),
      ),
    );
  }
}
