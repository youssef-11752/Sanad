import 'package:material_ui/material_ui.dart';

import '../../core/app_colors.dart';
import '../../core/models/profile_data.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/profile_data_field.dart';

/// Shows a profile to either account type. Each customer detail has its own
/// edit action; provider details are always read-only.
class PersonalProfileScreen extends StatefulWidget {
  final ProfileData profile;
  final bool canEdit;
  final Future<void> Function(ProfileData profile)? onSave;

  const PersonalProfileScreen({
    super.key,
    required this.profile,
    this.canEdit = false,
    this.onSave,
  }) : assert(!canEdit || onSave != null);

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

// one controller per editable field; only one field is edited at a time
class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _districtController;
  late ProfileData _profile;
  // name of the field currently being edited, null when nothing is being edited
  String? _editingField;
  // shown under the fields when saving fails
  String? _saveError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // keep a local copy so a saved edit shows immediately without waiting for the parent
    _profile = widget.profile;
    _nameController = TextEditingController(text: _profile.fullName);
    _phoneController = TextEditingController(text: _profile.phoneNumber);
    _cityController = TextEditingController(text: _profile.city);
    _districtController = TextEditingController(text: _profile.district);
  }

  @override
  void didUpdateWidget(covariant PersonalProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // do not overwrite the text the user is typing if the parent rebuilds mid-edit
    if (_editingField == null) {
      _profile = widget.profile;
      _copyProfileToFields();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // direction follows the app language, not the device
    final isRtl = l10n.localeName.startsWith('ar');
    final textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Directionality(
          textDirection: textDirection,
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
            // the form wraps all fields so validators run on the field being saved
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, l10n, isRtl),
                  const SizedBox(height: 25),
                  // each field has its own edit/save/cancel buttons
                  ProfileDataField(
                    label: l10n.fullNameLabel,
                    value: _profile.fullName,
                    isRtl: isRtl,
                    canEdit: widget.canEdit,
                    isEditing: _editingField == 'name',
                    controller: _nameController,
                    // name and city are required
                    validator: (value) => _requiredValidator(value, l10n),
                    editTooltip: l10n.editProfile,
                    saveTooltip: l10n.saveProfile,
                    cancelTooltip: l10n.cancel,
                    onEdit: _editAction('name'),
                    onSave: _isSaving ? null : () => _saveField('name', l10n),
                    onCancel: _isSaving ? null : _cancelEditing,
                  ),
                  const SizedBox(height: 16),
                  ProfileDataField(
                    label: l10n.phoneNumberLabel,
                    value: _profile.phoneNumber,
                    icon: Icons.phone_outlined,
                    isRtl: isRtl,
                    canEdit: widget.canEdit,
                    isEditing: _editingField == 'phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    // phone only needs a minimum number of digits
                    validator: (value) => _phoneValidator(value, l10n),
                    editTooltip: l10n.editProfile,
                    saveTooltip: l10n.saveProfile,
                    cancelTooltip: l10n.cancel,
                    onEdit: _editAction('phone'),
                    onSave: _isSaving ? null : () => _saveField('phone', l10n),
                    onCancel: _isSaving ? null : _cancelEditing,
                  ),
                  const SizedBox(height: 16),
                  ProfileDataField(
                    label: l10n.cityLabel,
                    value: _profile.city,
                    icon: Icons.location_on_outlined,
                    isRtl: isRtl,
                    canEdit: widget.canEdit,
                    isEditing: _editingField == 'city',
                    controller: _cityController,
                    validator: (value) => _requiredValidator(value, l10n),
                    editTooltip: l10n.editProfile,
                    saveTooltip: l10n.saveProfile,
                    cancelTooltip: l10n.cancel,
                    onEdit: _editAction('city'),
                    onSave: _isSaving ? null : () => _saveField('city', l10n),
                    onCancel: _isSaving ? null : _cancelEditing,
                  ),
                  const SizedBox(height: 16),
                  ProfileDataField(
                    label: l10n.districtLabel,
                    // show a dash when district is empty (it is optional, so no validator)
                    value: _profile.district.isEmpty ? '—' : _profile.district,
                    icon: Icons.place_outlined,
                    isRtl: isRtl,
                    canEdit: widget.canEdit,
                    isEditing: _editingField == 'district',
                    controller: _districtController,
                    editTooltip: l10n.editProfile,
                    saveTooltip: l10n.saveProfile,
                    cancelTooltip: l10n.cancel,
                    onEdit: _editAction('district'),
                    onSave: _isSaving
                        ? null
                        : () => _saveField('district', l10n),
                    onCancel: _isSaving ? null : _cancelEditing,
                  ),
                  const SizedBox(height: 16),
                  // password is only a placeholder here; changing it shows an "unavailable" message
                  ProfileDataField(
                    label: l10n.passwordLabel,
                    value: '••••••••',
                    icon: Icons.visibility_off_outlined,
                    isRtl: isRtl,
                    canEdit: widget.canEdit,
                    editTooltip: l10n.editProfile,
                    onEdit: () => _showPasswordMessage(l10n),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 1,
                      bottom: 21,
                    ),
                    child: Text(
                      l10n.profilePasswordHint,
                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
                      textDirection: textDirection,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.62,
                        ),
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // error from the last failed save
                  if (_saveError != null) ...[
                    Text(
                      _saveError!,
                      style: const TextStyle(color: AppColors.red),
                    ),
                    const SizedBox(height: 12),
                  ],
                  // plain close button, edits are saved per field so nothing to submit here
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shadowColor: const Color(0x55000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        l10n.profileOkay,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Title/subtitle and back button, mirrored for RTL.
  Widget _buildHeader(BuildContext context, AppLocalizations l10n, bool isRtl) {
    final primary = Theme.of(context).colorScheme.primary;
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);
    final title = Column(
      crossAxisAlignment: isRtl
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          l10n.personalProfile,
          style: TextStyle(
            color: primary,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(l10n.profileWelcome, style: TextStyle(color: muted, fontSize: 10)),
      ],
    );
    final backButton = IconButton(
      tooltip: l10n.backButtonTooltip,
      onPressed: () => Navigator.of(context).maybePop(),
      icon: Icon(isRtl ? Icons.arrow_forward : Icons.arrow_back, size: 19),
      color: primary,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 40),
    );

    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: isRtl
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: isRtl
          ? [Flexible(child: title), backButton]
          : [backButton, Flexible(child: title)],
    );
  }

  /// Returns the edit callback for a field, or null (disabled) when editing is not allowed
/// or another field is already being edited or saved.
  VoidCallback? _editAction(String field) {
    if (_editingField != null || _isSaving || !widget.canEdit) return null;
    return () => _startEditing(field);
  }

  String? _requiredValidator(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) return l10n.requiredField;
    return null;
  }

  String? _phoneValidator(String? value, AppLocalizations l10n) {
    // count Latin, Arabic-Indic and Persian digits so any keyboard works
    final digits = RegExp(r'[0-9٠-٩۰-۹]').allMatches(value ?? '').length;
    if (digits < 7) return l10n.invalidPhoneNumber;
    return null;
  }

  void _startEditing(String field) {
    _copyProfileToFields();
    setState(() => _editingField = field);
  }

  // discard unsaved text by restoring the controllers from the saved profile
  void _cancelEditing() {
    _copyProfileToFields();
    setState(() => _editingField = null);
  }

  void _copyProfileToFields() {
    _nameController.text = _profile.fullName;
    _phoneController.text = _profile.phoneNumber;
    _cityController.text = _profile.city;
    _districtController.text = _profile.district;
  }

  /// Validates, builds the updated profile for one field, and saves it through onSave.
  Future<void> _saveField(String field, AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;
    final save = widget.onSave;
    if (save == null) return;

    // only the edited field changes; the others keep their saved values
    final updatedProfile = switch (field) {
      'name' => _profile.copyWith(fullName: _nameController.text.trim()),
      'phone' => _profile.copyWith(phoneNumber: _phoneController.text.trim()),
      'city' => _profile.copyWith(city: _cityController.text.trim()),
      'district' => _profile.copyWith(
        district: _districtController.text.trim(),
      ),
      _ => _profile,
    };

    setState(() {
      _isSaving = true;
      _saveError = null;
    });
    try {
      await save(updatedProfile);
      // the screen may have been closed while the request was running
      if (!mounted) return;
      setState(() {
        _profile = updatedProfile;
        _editingField = null;
        _isSaving = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.profileSaved)));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        // show the localized message plus the raw error to help debugging
        _saveError = '${l10n.profileSaveError}\n$error';
      });
    }
  }

  void _showPasswordMessage(AppLocalizations l10n) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.passwordChangeUnavailable)));
  }
}
