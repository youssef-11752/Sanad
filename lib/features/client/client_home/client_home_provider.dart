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
      iconAsset: 'assets/icons/paint-roller.svg',
    ),
    ServiceModel(
      id: '2',
      title: 'صيانة الأجهزة المنزلية',
      category: HomeServiceCategory.appliances,
      iconAsset: 'assets/icons/washing-machine.svg',
    ),
    ServiceModel(
      id: '3',
      title: 'السباكة',
      category: HomeServiceCategory.plumbing,
      iconAsset: 'assets/icons/heater.svg',
    ),
    ServiceModel(
      id: '4',
      title: 'النجارة',
      category: HomeServiceCategory.carpentry,
      iconAsset: 'assets/icons/hammer.svg',
    ),
    ServiceModel(
      id: '5',
      title: 'الكهرباء',
      category: HomeServiceCategory.electrical,
      iconAsset: 'assets/icons/plug-zap.svg',
    ),
    ServiceModel(
      id: '6',
      title: 'صيانة المكيفات',
      category: HomeServiceCategory.airConditioning,
      iconAsset: 'assets/icons/snowflake.svg',
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
