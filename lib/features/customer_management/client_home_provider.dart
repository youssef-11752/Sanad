import 'package:flutter/material.dart';
import 'package:sanad/features/customer_management/models/order_model.dart';
import 'package:sanad/features/customer_management/models/provider_model.dart';
import 'package:sanad/features/customer_management/models/service_model.dart';

class ClientHomeProvider extends ChangeNotifier {
  // Presentation placeholders from the original customer-home UI submission.
  // Replace these lists with Supabase repositories in the customer-home sprint.
  final List<ServiceModel> _services = [
    ServiceModel(id: '1', title: 'النقاشة', icon: Icons.format_paint_outlined),
    ServiceModel(id: '2', title: 'صيانة الأجهزة المنزلية', icon: Icons.home_repair_service_outlined),
    ServiceModel(id: '3', title: 'السباكة', icon: Icons.plumbing_outlined),
    ServiceModel(id: '4', title: 'النجارة', icon: Icons.handyman_outlined),
    ServiceModel(id: '5', title: 'الكهرباء', icon: Icons.electrical_services_outlined),
    ServiceModel(id: '6', title: 'صيانة المركبات', icon: Icons.directions_car_outlined),
  ];

  final List<OrderModel> _orders = [
    OrderModel(
      id: 'SN-2048',
      title: 'إصلاح غسالة أوتوماتيك',
      status: 'زيارة مجدولة',
      date: 'الأحد، 8 نوفمبر',
      details: 'أحمد سمير • مدينة نصر',
    ),
  ];

  final List<ProviderModel> _providers = [
    ProviderModel(
      id: '1',
      name: 'أحمد سمير',
      initial: 'أ س',
      speciality: 'متخصص غسالات وثلاجات',
      rating: '4.9 (128 تقييم)',
      experience: 'خبرة 8 سنوات',
      availablity: 'متاح غدًا',
      price: 150,
    ),
    ProviderModel(
      id: '2',
      name: 'محمد علي',
      initial: 'م ع',
      speciality: 'متخصص غسالات وثلاجات',
      rating: '4.8 (86 تقييم)',
      experience: 'خبرة 6 سنوات',
      availablity: 'متاح غدًا',
      price: 150,
    ),
  ];

  List<ServiceModel> get services => List.unmodifiable(_services);
  List<OrderModel> get orders => List.unmodifiable(_orders);
  List<ProviderModel> get providers => List.unmodifiable(_providers);
}
