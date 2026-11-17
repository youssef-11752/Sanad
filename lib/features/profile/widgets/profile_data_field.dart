import 'package:material_ui/material_ui.dart';

import '../../../core/app_colors.dart';

/// A profile value field shared by the read-only and edit views.
// Callers pass in the controller and the edit/save/cancel callbacks, so this
// widget only handles layout and which controls to show.
class ProfileDataField extends StatelessWidget {
  final String label;
  final String value;
  final bool isRtl;
  final bool isEditing;
  final bool canEdit;
  final TextEditingController? controller;
  final IconData? icon;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String editTooltip;
  final String saveTooltip;
  final String cancelTooltip;
  final VoidCallback? onEdit;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const ProfileDataField({
    super.key,
    required this.label,
    required this.value,
    required this.isRtl,
    this.canEdit = false,
    this.isEditing = false,
    this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.editTooltip = 'Edit',
    this.saveTooltip = 'Save',
    this.cancelTooltip = 'Cancel',
    this.onEdit,
    this.onSave,
    this.onCancel,
  });

  // Shows a small label above a bordered box with the value, an optional
  // leading icon and, when editable, the action buttons.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    // Text direction follows the app language (Arabic is RTL).
    final direction = isRtl ? TextDirection.rtl : TextDirection.ltr;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          textDirection: direction,
          style: TextStyle(
            color: primary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7),
        // The box keeps a minimum height so it doesn't jump when switching to edit mode.
        Container(
          constraints: const BoxConstraints(minHeight: 45),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: AppColors.coral, width: 0.8),
          ),
          // Forced LTR so the icon and buttons stay in the same spots; the text inside
          // sets its own direction.
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              if (icon != null) ...[
                const SizedBox(width: 11),
                Icon(icon, color: primary.withValues(alpha: 0.85), size: 16),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 9, end: 11),
                  // In edit mode the value becomes a form field, otherwise plain text.
                  child: isEditing
                      ? TextFormField(
                          controller: controller,
                          keyboardType: keyboardType,
                          validator: validator,
                          textDirection: direction,
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 11,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        )
                      : Text(
                          value,
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                          textDirection: direction,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 11,
                          ),
                        ),
                ),
              ),
              // Action buttons only appear when the field is editable: save/cancel while
              // editing, a single edit pencil otherwise.
              if (canEdit) ...[
                if (isEditing) ...[
                  IconButton(
                    tooltip: saveTooltip,
                    onPressed: onSave,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 40,
                    ),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.check, size: 17),
                    color: primary,
                  ),
                  IconButton(
                    tooltip: cancelTooltip,
                    onPressed: onCancel,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 40,
                    ),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close, size: 17),
                    color: primary,
                  ),
                ] else
                  IconButton(
                    tooltip: editTooltip,
                    onPressed: onEdit,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 40,
                    ),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    color: primary,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
