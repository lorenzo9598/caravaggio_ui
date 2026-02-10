import 'dart:developer';

import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class FieldsPage extends StatefulWidget {
  const FieldsPage({super.key});

  @override
  State<FieldsPage> createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  void _onChanged(String? value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value ?? 'No value')));
  }

  void _onFieldChanged(String value) {
    log(value);
  }

  String _optionsValueToMatch(String value) => value.toLowerCase();

  static const double _cardPadding = 16.0;
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  /// Wraps a field in a Form to enable validation display
  Widget _wrapFieldInForm(Widget field) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: field,
    );
  }

  Widget _buildFieldCard({
    required String label,
    required Widget field,
  }) {
    return Container(
      padding: const EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(
            label,
            size: TextSize.small,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),
          field,
        ],
      ),
    );
  }

  Widget _buildFieldSection(
    BuildContext context,
    String title,
    List<(String label, Widget field)> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CText.headline(title, size: TextSize.medium),
        ),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(
                bottom: items.indexOf(item) < items.length - 1 ? _itemSpacing : 0,
              ),
              child: _buildFieldCard(label: item.$1, field: item.$2),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fields')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFieldSection(
              context,
              'Field Styles',
              [
                (
                  'Simple',
                  CTextField.simple(
                    decoration: textFieldDecoration,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Bordered',
                  CTextField.bordered(
                    decoration: textFieldDecoration,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Filled',
                  CTextField.filled(
                    decoration: textFieldDecoration,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Bordered Filled',
                  CTextField.borderedFilled(
                    decoration: textFieldDecoration,
                    onChanged: _onFieldChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Border Radius',
              [
                (
                  'Extra Extra Small (xxs)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.xxs),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Extra Small (xs)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.xs),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Small (s)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.s),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Medium (m)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.m),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Large (l)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.l),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Extra Large (xl)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.xl),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Extra Extra Large (xxl)',
                  CTextField.filled(
                    decoration: textFieldDecoration.copyWith(radius: AppRadius.xxl),
                    onChanged: _onFieldChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Label Icon & Required',
              [
                (
                  'With Label Icon',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Titolo",
                      hintText: "Es. Cena di compleanno",
                      labelIcon: Icon(Icons.text_fields, color: Color(0xFF6B7280)),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Required Field',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Titolo",
                      hintText: "Es. Cena di compleanno",
                      required: true,
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'With Label Icon & Required',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Titolo",
                      hintText: "Es. Cena di compleanno",
                      labelIcon: Icon(Icons.text_fields, color: Color(0xFF6B7280)),
                      required: true,
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Textarea',
              [
                (
                  'Simple Textarea',
                  CTextField.simple(
                    decoration: const CFieldDecoration(
                      labelText: "Description",
                      hintText: "Enter your description here...",
                    ),
                    maxLines: 4,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Bordered Textarea',
                  CTextField.bordered(
                    decoration: const CFieldDecoration(
                      labelText: "Comments",
                      hintText: "Write your comments...",
                    ),
                    maxLines: 5,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Filled Textarea',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Message",
                      hintText: "Type your message here...",
                    ),
                    maxLines: 6,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Bordered Filled Textarea',
                  CTextField.borderedFilled(
                    decoration: const CFieldDecoration(
                      labelText: "Notes",
                      hintText: "Add your notes...",
                    ),
                    maxLines: 4,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Textarea with Label Icon',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Description",
                      hintText: "Enter description...",
                      labelIcon: Icon(Icons.description, color: Color(0xFF6B7280)),
                    ),
                    maxLines: 5,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Textarea Required',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Message",
                      hintText: "Enter your message...",
                      required: true,
                    ),
                    maxLines: 4,
                    onChanged: _onFieldChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Custom Label Widget',
              [
                (
                  'Label with Custom Widget',
                  CTextField.filled(
                    decoration: CFieldDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.email, size: 16, color: CColors.primaryColor),
                          const SizedBox(width: 6),
                          CText.label('Email Address', size: TextSize.small),
                        ],
                      ),
                      hintText: "Enter your email",
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Label with Badge',
                  CTextField.filled(
                    decoration: CFieldDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CText.label('Username', size: TextSize.small),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: CColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: CText.label(
                              'New',
                              size: TextSize.small,
                              style: TextStyle(
                                color: CColors.primaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hintText: "Enter username",
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Label with Icon and Required',
                  CTextField.filled(
                    decoration: CFieldDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock, size: 16, color: CColors.primaryColor),
                          const SizedBox(width: 6),
                          CText.label('Password', size: TextSize.small),
                          const SizedBox(width: 4),
                          CText.label(
                            '*',
                            size: TextSize.small,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      hintText: "Enter password",
                    ),
                    obscureText: true,
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Label with Multiple Elements',
                  CTextField.filled(
                    decoration: CFieldDecoration(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: CColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.person, size: 14, color: CColors.primaryColor),
                          ),
                          const SizedBox(width: 8),
                          CText.label('Full Name', size: TextSize.small),
                          const SizedBox(width: 4),
                          CText.label(
                            '*',
                            size: TextSize.small,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      hintText: "Enter your full name",
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Label with Custom Styling',
                  CTextField.bordered(
                    decoration: CFieldDecoration(
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: CGradient.primaryToSecondary.opacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CText.label(
                          'Custom Styled Label',
                          size: TextSize.small,
                          style: TextStyle(
                            color: CColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      hintText: "Enter text",
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Icons',
              [
                (
                  'With Prefix Icon',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Label",
                      hintText: "Enter text",
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'With Suffix Icon',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Label",
                      hintText: "Enter text",
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'With Both Icons',
                  CTextField.filled(
                    decoration: const CFieldDecoration(
                      labelText: "Label",
                      hintText: "Enter text",
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: Icon(Icons.check),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Bordered with Icons',
                  CTextField.bordered(
                    decoration: const CFieldDecoration(
                      labelText: "Label",
                      hintText: "Enter text",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Simple with Icons',
                  CTextField.simple(
                    decoration: const CFieldDecoration(
                      labelText: "Label",
                      hintText: "Enter text",
                      prefixIcon: Icon(Icons.phone),
                      suffixIcon: Icon(Icons.call),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
                (
                  'Bordered Filled with Icons',
                  CTextField.borderedFilled(
                    decoration: const CFieldDecoration(
                      labelText: "Label",
                      hintText: "Enter text",
                      prefixIcon: Icon(Icons.location_on),
                      suffixIcon: Icon(Icons.map),
                    ),
                    onChanged: _onFieldChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Error Messages',
              [
                (
                  'Filled Field with Error',
                  _wrapFieldInForm(
                    CTextField.filled(
                      decoration: const CFieldDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        required: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: _onFieldChanged,
                    ),
                  ),
                ),
                (
                  'Bordered Field with Error',
                  _wrapFieldInForm(
                    CTextField.bordered(
                      decoration: const CFieldDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        required: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: _onFieldChanged,
                    ),
                  ),
                ),
                (
                  'Simple Field with Error',
                  _wrapFieldInForm(
                    CTextField.simple(
                      decoration: const CFieldDecoration(
                        labelText: "Username",
                        hintText: "Enter username",
                        labelIcon: Icon(Icons.person, color: Color(0xFF6B7280)),
                        required: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                      onChanged: _onFieldChanged,
                    ),
                  ),
                ),
                (
                  'Bordered Filled with Error',
                  _wrapFieldInForm(
                    CTextField.borderedFilled(
                      decoration: const CFieldDecoration(
                        labelText: "Phone Number",
                        hintText: "Enter phone number",
                        prefixIcon: Icon(Icons.phone),
                        required: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter only numbers';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      onChanged: _onFieldChanged,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildFieldSection(
              context,
              'Other Field Types',
              [
                (
                  'Autocomplete (Filled)',
                  CAutocomplete<String>.filled(
                    options: options,
                    decoration: demoDecoration,
                    optionsValueToMatch: _optionsValueToMatch,
                    displayStringForOption: (value) => value,
                    searchItems: () {},
                  ),
                ),
                (
                  'Dropdown (Filled)',
                  CDropdown<String>.filled(
                    items: dropdownItems,
                    decoration: demoDecoration,
                    onChanged: _onChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
