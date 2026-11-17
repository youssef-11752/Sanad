import 'package:material_ui/material_ui.dart';

import 'package:sanad/features/client/client_home/models/provider_model.dart';
import 'package:sanad/features/client/client_home/models/service_model.dart';

/// Holds the data shown on the client home screen and notifies listeners when it changes.
/// For now the lists are hard-coded sample data (Arabic titles are shown to users).
class ClientHomeProvider extends ChangeNotifier {
  // services in the client home screen
  final List<ServiceModel> _services = [
    ServiceModel(
      id: '1',
      title: 'النقاشة',
      category: HomeServiceCategory.painting,
      icon: Icons.format_paint_outlined,
    ),
    ServiceModel(
      id: '2',
      title: 'صيانة الأجهزة المنزلية',
      category: HomeServiceCategory.appliances,
      icon: Icons.home_repair_service_outlined,
    ),
    ServiceModel(
      id: '3',
      title: 'السباكة',
      category: HomeServiceCategory.plumbing,
      icon: Icons.plumbing_outlined,
    ),
    ServiceModel(
      id: '4',
      title: 'النجارة',
      category: HomeServiceCategory.carpentry,
      icon: Icons.handyman_outlined,
    ),
    ServiceModel(
      id: '5',
      title: 'الكهرباء',
      category: HomeServiceCategory.electrical,
      icon: Icons.electrical_services_outlined,
    ),
    ServiceModel(
      id: '6',
      title: 'صيانة المكيفات',
      category: HomeServiceCategory.airConditioning,
      icon: Icons.ac_unit,
    ),
  ];

  // recommended services providers
  final List<ProviderModel> _providers = [
    ProviderModel(
      id: '1',
      name: 'أحمد سمير',
      initial: 'أ س',
      rating: '4.9',
      reviewCount: 126,
      experienceYears: 8,
      availableToday: true,
      price: 150,
    ),
    ProviderModel(
      id: '2',
      name: 'محمد علي',
      initial: 'م ع',
      rating: '4.1',
      reviewCount: 119,
      experienceYears: 6,
      availableToday: false,
      price: 150,
    ),
  ];

  // getters to access private data "we can access the lists through provider"
  List<ServiceModel> get services => _services;
  List<ProviderModel> get providers => _providers;
}
