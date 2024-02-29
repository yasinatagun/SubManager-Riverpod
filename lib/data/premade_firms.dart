import 'package:flutter/material.dart';
import 'package:subscription_manager/models/category.dart';
import 'package:subscription_manager/models/subscription_firm.dart';
final categories = {
  Categories.education: Category(categoryName: "Education", color: Colors.red),
  Categories.business: Category(categoryName: "Business", color: Colors.amber),
  Categories.entertainment: Category(categoryName: "Entertainment", color: Colors.purple),
  Categories.finance: Category(categoryName: "Finance", color: Colors.green),
  Categories.game: Category(categoryName: "Game", color: Colors.black),
  Categories.sport: Category(categoryName: "Sport", color: Colors.blue),
  Categories.website: Category(categoryName: "Website", color: Colors.deepOrange),

};


List<SubscriptionFirm> subscriptionFirmList = [
  SubscriptionFirm(
      name: "Netflix",
      imageUrl: "assets/images/netflix.png",
      category: categories[Categories.entertainment]!),
  SubscriptionFirm(
      name: "Amazon",
      imageUrl: "assets/images/prime.png",
      category: categories[Categories.entertainment]!),
  SubscriptionFirm(
      name: "Exxen",
      imageUrl: "assets/images/exxen.png",
      category: categories[Categories.entertainment]!),
  
  SubscriptionFirm(
      name: "TickTick",
      imageUrl: "assets/images/ticktick.png",
      category: categories[Categories.business]!),
  SubscriptionFirm(
      name: "Medium",
      imageUrl: "assets/images/medium.png",
      category: categories[Categories.education]!),
      SubscriptionFirm(
      name: "PomoTodo",
      imageUrl: "assets/images/pomodoro.png",
      category: categories[Categories.business]!),SubscriptionFirm(
      name: "Steam",
      imageUrl: "assets/images/steam.png",
      category: categories[Categories.game]!),SubscriptionFirm(
      name: "Knight Online",
      imageUrl: "assets/images/knight.png",
      category: categories[Categories.game]!),SubscriptionFirm(
      name: "BTC Turk",
      imageUrl: "assets/images/btc.png",
      category: categories[Categories.finance]!),SubscriptionFirm(
      name: "Yapı Kredi",
      imageUrl: "assets/images/banking.png",
      category: categories[Categories.finance]!),SubscriptionFirm(
      name: "Gym",
      imageUrl: "assets/images/gym.png",
      category: categories[Categories.sport]!),SubscriptionFirm(
      name: "Chegg",
      imageUrl: "assets/images/chegg.png",
      category: categories[Categories.website]!),
      SubscriptionFirm(
      name: "Disney",
      imageUrl: "assets/images/netflix.png",
      category: categories[Categories.entertainment]!),
  SubscriptionFirm(
      name: "Hulu",
      imageUrl: "assets/images/netflix.png",
      category: categories[Categories.entertainment]!),
  SubscriptionFirm(
      name: "PuhuTv",
      imageUrl: "assets/images/netflix.png",
      category: categories[Categories.entertainment]!),
];
