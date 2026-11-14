
import 'package:flutter/material.dart';

import '../../data/models/order_model.dart';
import '../../data/models/provider_model.dart';
import '../../data/models/service_model.dart';

class ClientHomeProvider extends ChangeNotifier {

  // services in the client home screen
  final List<ServiceModel> _services = [
    ServiceModel(
      id: '1',
      title: 'النقاشة',
      icon: Icons.format_paint_outlined,
    ),
    ServiceModel(
      id: '2',
      title: 'صيانة الأجهزة المنزلية',
      icon: Icons.home_repair_service_outlined,
    ),
    ServiceModel(
      id: '3',
      title: 'السباكة',
      icon: Icons.plumbing_outlined,
    ),
    ServiceModel(
      id: '4',
      title: 'النجارة',
      icon: Icons.handyman_outlined,
    ),
    ServiceModel(
      id: '5',
      title: 'الكهرباء',
      icon: Icons.electrical_services_outlined,
    ),
    ServiceModel(
      id: '6',
      title: 'صيانة المفروشات',
      icon: Icons.weekend_outlined,
    ),
  ];

  // current order
  final List<OrderModel> _orders = [
    OrderModel(
      id: 'SN-2048',
      title: 'إصلاح غسالة أوتوماتيك',
      status: 'زيارة مجدولة',
      date: 'الأحد، 10 نوفمبر',
      details: 'أحمد محمود • مدينة نصر',
    ),
  ];

  // recommended services providers
  final List<ProviderModel> _providers = [
    ProviderModel(
      id: '1',
      name: 'أحمد سمير',
      initial: 'أ س',
      speciality: 'متخصص صيانة وإصلاح الأجهزة',
      rating: '4.9 (126 تقييم)',
      experience: 'خبرة 8 سنوات', 
      availablity: 'متاح اليوم',
      price: 150
    ),
    ProviderModel(
      id: '2',
      name: 'محمد علي',
      initial: 'م ع',
      speciality: 'متخصص صيانة وإصلاح الأجهزة',
      rating: '4.1 (119 تقييم)',
      experience: 'خبرة 6 سنوات', 
      availablity: 'متاح غدا',
      price: 150
    ),
  ];

  // getters to access private data "we can access the lists through provider"
  List<ServiceModel> get services => _services;
  List<OrderModel> get orders => _orders;
  List<ProviderModel> get providers => _providers;
}
