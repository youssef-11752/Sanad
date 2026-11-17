import 'package:material_ui/material_ui.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:go_router/go_router.dart';
import 'package:sanad/core/theme/colors.dart';
import 'package:sanad/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key, this.initialCategory});

  final String? initialCategory;

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  final _addressController = TextEditingController();
  late Future<_RequestOptions> _optionsFuture;
  int? _selectedCategoryId;
  int? _selectedCityId;
  bool _isSubmitting = false;
  String? _submitError;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialCategory ?? '';
    final metadata =
        Supabase.instance.client.auth.currentUser?.userMetadata ??
        const <String, dynamic>{};
    final region = metadata['region'];
    if (region is String) {
      _addressController.text = region.trim();
    }
    _optionsFuture = _loadOptions();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<_RequestOptions> _loadOptions() async {
    final client = Supabase.instance.client;
    final categoryRows = await client
        .from('categories')
        .select('id, name')
        .order('name');
    final cityRows = await client
        .from('cities')
        .select('id, name')
        .order('name');
    final categories = categoryRows.map(_RequestOption.fromRow).toList();
    final cities = cityRows.map(_RequestOption.fromRow).toList();

    _selectedCategoryId ??= _matchOption(
      categories,
      widget.initialCategory,
    )?.id;
    final metadata = client.auth.currentUser?.userMetadata ?? const {};
    final city = metadata['city'];
    if (_selectedCityId == null && city is String) {
      _selectedCityId = _matchOption(cities, city)?.id;
    }

    return _RequestOptions(categories: categories, cities: cities);
  }

  _RequestOption? _matchOption(List<_RequestOption> options, String? name) {
    if (name == null || name.trim().isEmpty) return null;
    final normalizedName = name.trim().toLowerCase();
    const categoryAliases = <String, List<String>>{
      'النقاشة': ['painting'],
      'painting': ['النقاشة'],
      'النجارة': ['carpentry'],
      'carpentry': ['النجارة'],
      'الكهرباء': ['electrical'],
      'electrical': ['الكهرباء'],
      'السباكة': ['plumbing'],
      'plumbing': ['السباكة'],
      'صيانة المكيفات': ['air conditioning', 'air conditioner'],
      'air conditioning': ['صيانة المكيفات'],
      'صيانة الأجهزة المنزلية': [
        'home appliance maintenance',
        'appliance maintenance',
      ],
      'home appliance maintenance': ['صيانة الأجهزة المنزلية'],
      'appliance maintenance': ['صيانة الأجهزة المنزلية'],
    };
    final names = {normalizedName, ...?categoryAliases[normalizedName]};
    for (final option in options) {
      if (names.contains(option.name.trim().toLowerCase())) return option;
    }
    return null;
  }

  String _categoryDisplayName(String name, AppLocalizations localizations) {
    return switch (name.trim().toLowerCase()) {
      'home appliance maintenance' ||
      'appliance maintenance' ||
      'صيانة الأجهزة المنزلية' => localizations.applianceCategory,
      'painting' || 'النقاشة' => localizations.paintingCategory,
      'carpentry' || 'النجارة' => localizations.carpentryCategory,
      'electrical' || 'الكهرباء' => localizations.electricalCategory,
      'air conditioning' ||
      'air conditioner' ||
      'صيانة المكيفات' => localizations.airConditioningCategory,
      'plumbing' || 'السباكة' => localizations.plumbingCategory,
      _ => name,
    };
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    final categoryId = _selectedCategoryId;
    final cityId = _selectedCityId;
    if (categoryId == null || cityId == null) return;

    setState(() {
      _isSubmitting = true;
      _submitError = null;
    });

    try {
      final client = Supabase.instance.client;
      final user = client.auth.currentUser;
      if (user == null) {
        throw StateError('You must sign in before creating a request.');
      }

      await client.from('issues').insert({
        'user_id': user.id,
        'category_id': categoryId,
        'city_id': cityId,
        'address': _addressController.text.trim(),
        'title': _titleController.text.trim(),
        'description': _detailsController.text.trim(),
        'status': 'pending',
      });

      if (!mounted) return;
      final localizations = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.requestCreatedMessage)),
      );
      context.go(
        '/customer/requests?refresh=${DateTime.now().microsecondsSinceEpoch}',
      );
    } catch (error) {
      if (mounted) {
        final localizations = AppLocalizations.of(context)!;
        setState(() {
          _submitError = '${localizations.requestCreateError}\n$error';
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _retryLoadingOptions() async {
    setState(() {
      _optionsFuture = _loadOptions();
    });
  }

  Widget _buildRequestForm(
    _RequestOptions options,
    AppLocalizations localizations,
    bool isArabic,
  ) {
    final hasCategories = options.categories.isNotEmpty;
    final hasCities = options.cities.isNotEmpty;

    return SingleChildScrollView(
      padding: const widgets.EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!hasCategories)
                  Text(
                    localizations.requestNoCategories,
                    style: const TextStyle(color: AppThemes.redColor),
                  ),
                if (!hasCities)
                  Text(
                    localizations.requestNoCities,
                    style: const TextStyle(color: AppThemes.redColor),
                  ),
                if (!hasCategories || !hasCities) ...[
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isSubmitting ? null : _retryLoadingOptions,
                    child: Text(localizations.retryButton),
                  ),
                  const SizedBox(height: 12),
                ],
                if (hasCategories) ...[
                  Text(
                    localizations.requestCategoryLabel,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    key: const Key('request-category'),
                    initialValue: _selectedCategoryId,
                    decoration: InputDecoration(
                      hintText: localizations.chooseRequestCategory,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      for (final category in options.categories)
                        DropdownMenuItem(
                          value: category.id,
                          child: Text(
                            _categoryDisplayName(category.name, localizations),
                          ),
                        ),
                    ],
                    onChanged: _isSubmitting
                        ? null
                        : (value) => setState(() {
                            _selectedCategoryId = value;
                          }),
                    validator: (value) =>
                        value == null ? localizations.errorFieldRequired : null,
                  ),
                  const SizedBox(height: 14),
                ],
                Text(
                  localizations.requestTitleLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  key: const Key('request-title'),
                  controller: _titleController,
                  enabled: !_isSubmitting,
                  textDirection: isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? localizations.errorFieldRequired
                      : null,
                ),
                const SizedBox(height: 14),
                Text(
                  localizations.requestDetailsLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  key: const Key('request-details'),
                  controller: _detailsController,
                  enabled: !_isSubmitting,
                  minLines: 3,
                  maxLines: 5,
                  textDirection: isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? localizations.errorFieldRequired
                      : null,
                ),
                if (hasCities) ...[
                  const SizedBox(height: 14),
                  Text(
                    localizations.requestCityLabel,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    key: const Key('request-city'),
                    initialValue: _selectedCityId,
                    decoration: InputDecoration(
                      hintText: localizations.chooseRequestCity,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      for (final city in options.cities)
                        DropdownMenuItem(
                          value: city.id,
                          child: Text(city.name),
                        ),
                    ],
                    onChanged: _isSubmitting
                        ? null
                        : (value) => setState(() {
                            _selectedCityId = value;
                          }),
                    validator: (value) =>
                        value == null ? localizations.errorFieldRequired : null,
                  ),
                ],
                const SizedBox(height: 14),
                Text(
                  localizations.requestAddressLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  key: const Key('request-address'),
                  controller: _addressController,
                  enabled: !_isSubmitting,
                  textDirection: isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? localizations.errorFieldRequired
                      : null,
                ),
                if (_submitError != null) ...[
                  const SizedBox(height: 12),
                  SelectableText(
                    _submitError!,
                    style: const TextStyle(color: AppThemes.redColor),
                  ),
                ],
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: _isSubmitting || !hasCategories || !hasCities
                      ? null
                      : _submitRequest,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(localizations.requestSubmitButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppThemes.cremeyColor,
        appBar: AppBar(
          title: Text(localizations.newRequestTitle),
          backgroundColor: AppThemes.cremeyColor,
          leading: IconButton(
            tooltip: localizations.backNavigation,
            icon: Icon(
              isArabic ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/customer/management');
              }
            },
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<_RequestOptions>(
            future: _optionsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const widgets.EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${localizations.requestOptionsError}\n'
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: _retryLoadingOptions,
                          child: Text(localizations.retryButton),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return _buildRequestForm(
                snapshot.requireData,
                localizations,
                isArabic,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RequestOptions {
  const _RequestOptions({required this.categories, required this.cities});

  final List<_RequestOption> categories;
  final List<_RequestOption> cities;
}

class _RequestOption {
  const _RequestOption({required this.id, required this.name});

  final int id;
  final String name;

  factory _RequestOption.fromRow(Map<String, dynamic> row) {
    final id = row['id'];
    final name = row['name'];
    if (id is! int || name is! String || name.trim().isEmpty) {
      throw const FormatException('A request option has invalid data.');
    }
    return _RequestOption(id: id, name: name.trim());
  }
}
