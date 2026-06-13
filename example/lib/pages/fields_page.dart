import 'dart:developer';

import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class FieldsPage extends StatefulWidget {
  const FieldsPage({super.key});

  @override
  State<FieldsPage> createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  void _onChanged(String? value) {
    CToast.of(context).showMessage(
      title: value ?? 'No value',
      variant: CToastVariant.info,
    );
  }

  void _onFieldChanged(String value) {
    log(value);
  }

  String _optionsValueToMatch(String value) => value.toLowerCase();

  /// Wraps a field in a Form to enable validation display
  Widget _wrapFieldInForm(Widget field) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: field,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.fields,
      title: demoScaffoldTitleFor(DemoPageId.fields),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Styles',
              icon: Icons.style_outlined,
              items: [
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
            Section(
              title: 'Border Radius',
              icon: Icons.rounded_corner,
              items: [
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
            Section(
              title: 'Label Icon & Required',
              icon: Icons.label_outline,
              items: [
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
            Section(
              title: 'Textarea',
              icon: Icons.notes_outlined,
              items: [
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
            Section(
              title: 'Custom Label Widget',
              icon: Icons.badge_outlined,
              items: [
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
            Section(
              title: 'Icons',
              icon: Icons.add_reaction_outlined,
              items: [
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
            Section(
              title: 'Error Messages',
              icon: Icons.error_outline,
              items: [
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
            Section(
              title: 'Other Field Types',
              icon: Icons.more_horiz,
              items: [
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
        );
      },
    );
  }
}
