import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class ComplexFormPage extends StatefulWidget {
  const ComplexFormPage({super.key});

  @override
  State<ComplexFormPage> createState() => _ComplexFormPageState();
}

class _ComplexFormPageState extends State<ComplexFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _categoryController = CDropdownController<String>();
  final _remindersController = CCheckboxController();
  final _termsController = CCheckboxController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _dateError;
  String? _timeError;
  bool _submitting = false;

  static final _sessionTypes = [
    CDropdownItemModel<String>(value: 'workshop', text: 'Workshop'),
    CDropdownItemModel<String>(value: 'meeting', text: 'Client meeting'),
    CDropdownItemModel<String>(value: 'training', text: 'Training'),
    CDropdownItemModel<String>(value: 'social', text: 'Team social'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    _notesController.dispose();
    _categoryController.dispose();
    _remindersController.dispose();
    _termsController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  String _formatTime(TimeOfDay time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  bool _validateSchedule() {
    var valid = true;
    String? dateError;
    String? timeError;

    if (_selectedDate == null) {
      dateError = 'Choose a date for your session';
      valid = false;
    }
    if (_selectedTime == null) {
      timeError = 'Pick a preferred start time';
      valid = false;
    }

    setState(() {
      _dateError = dateError;
      _timeError = timeError;
    });
    return valid;
  }

  Future<void> _onSubmit() async {
    if (_submitting) return;

    final fieldsValid = _formKey.currentState!.validate();
    final scheduleValid = _validateSchedule();

    if (!_termsController.value) {
      CToast.of(context).showMessage(
        title: 'Terms required',
        subtitle: 'Please accept the venue terms to continue',
        variant: CToastVariant.warning,
      );
      return;
    }

    if (!fieldsValid || !scheduleValid) {
      return;
    }

    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    final category = _categoryController.value;
    final categoryLabel = _sessionTypes.firstWhere((item) => item.value == category, orElse: () => _sessionTypes.first).text;

    setState(() => _submitting = false);

    CToast.of(context).showMessage(
      title: 'Session booked',
      subtitle: '${_titleController.text.trim()} ($categoryLabel) '
          'on ${_formatDate(_selectedDate!)} at ${_formatTime(_selectedTime!)}'
          '${_remindersController.value ? ' — reminder scheduled' : ''}',
      variant: CToastVariant.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final muted = theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7);

    return CustomScaffold(
      title: demoScaffoldTitle('Book event'),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 12, 16, 24),
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.all(AppRadius.l),
                boxShadow: AppShadow.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(AppRadius.m),
                            gradient: CGradient.primaryToSecondary,
                          ),
                          child: const Icon(Icons.event_available, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText.headline('New booking', size: TextSize.small),
                              const SizedBox(height: 4),
                              CText.body(
                                'Rooms 2–4 · Mon–Fri, 8:00–18:00',
                                size: TextSize.small,
                                style: TextStyle(color: muted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: CColors.secondary.shade200),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _FormSectionTitle(label: 'Your details'),
                          const SizedBox(height: 12),
                          CTextField.filled(
                            controller: _nameController,
                            decoration: const CFieldDecoration(
                              labelText: 'Full name',
                              hintText: 'Alex Morgan',
                              labelIcon: Icon(Icons.person_outline, color: Color(0xFF6B7280)),
                              required: true,
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 14),
                          CTextField.filled(
                            controller: _emailController,
                            decoration: const CFieldDecoration(
                              labelText: 'Work email',
                              hintText: 'you@company.com',
                              prefixIcon: Icon(Icons.email_outlined),
                              required: true,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 24),
                          _FormSectionTitle(label: 'Session'),
                          const SizedBox(height: 12),
                          CTextField.filled(
                            controller: _titleController,
                            decoration: const CFieldDecoration(
                              labelText: 'Session title',
                              hintText: 'Q3 planning workshop',
                              labelIcon: Icon(Icons.title, color: Color(0xFF6B7280)),
                              required: true,
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Give your session a title';
                              }
                              return null;
                            },
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 14),
                          CDropdown<String>.filled(
                            items: _sessionTypes,
                            controller: _categoryController,
                            decoration: const CFieldDecoration(
                              labelText: 'Session type',
                              hintText: 'What kind of event is this?',
                              required: true,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Select a session type';
                              }
                              return null;
                            },
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 14),
                          CTextField.filled(
                            controller: _notesController,
                            decoration: const CFieldDecoration(
                              labelText: 'Notes for the venue',
                              hintText: 'Catering, AV setup, expected headcount…',
                              labelIcon: Icon(Icons.notes_outlined, color: Color(0xFF6B7280)),
                            ),
                            maxLines: 3,
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 24),
                          _FormSectionTitle(label: 'When'),
                          const SizedBox(height: 12),
                          _ScheduleField(
                            label: 'Date',
                            value: _selectedDate != null ? _formatDate(_selectedDate!) : null,
                            placeholder: 'Select a day',
                            error: _dateError,
                            child: CDatePicker(
                              mode: CustomDatePickerMode.single,
                              firstDate: now,
                              lastDate: now.add(const Duration(days: 60)),
                              onChanged: (dates) {
                                setState(() {
                                  _selectedDate = dates.isNotEmpty ? dates.first : null;
                                  _dateError = null;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          _ScheduleField(
                            label: 'Preferred time',
                            value: _selectedTime != null ? _formatTime(_selectedTime!) : null,
                            placeholder: 'Select a start time',
                            error: _timeError,
                            child: CTimePicker(
                              mode: CustomTimePickerMode.single,
                              maxLines: 3,
                              quickTimes: const [
                                TimeOfDay(hour: 9, minute: 0),
                                TimeOfDay(hour: 10, minute: 30),
                                TimeOfDay(hour: 14, minute: 0),
                                TimeOfDay(hour: 15, minute: 30),
                                TimeOfDay(hour: 17, minute: 0),
                              ],
                              onChanged: (times) {
                                setState(() {
                                  _selectedTime = times.isNotEmpty ? times.first : null;
                                  _timeError = null;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          _FormSectionTitle(label: 'Before you submit'),
                          const SizedBox(height: 10),
                          CCheckbox(
                            controller: _remindersController,
                            label: 'Email me a reminder the day before',
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 8),
                          CCheckbox(
                            controller: _termsController,
                            label: 'I agree to the venue booking terms',
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 24),
                          CButton.elevated(
                            onPressed: _submitting ? null : _onSubmit,
                            child: CText.label(_submitting ? 'Booking…' : 'Confirm booking'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FormSectionTitle extends StatelessWidget {
  const _FormSectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return CText.label(label, size: TextSize.small);
  }
}

class _ScheduleField extends StatelessWidget {
  const _ScheduleField({
    required this.label,
    required this.placeholder,
    required this.child,
    this.value,
    this.error,
  });

  final String label;
  final String placeholder;
  final String? value;
  final String? error;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText.body(label, size: TextSize.small),
            const SizedBox(height: 2),
            CText.body(
              selected ? value! : placeholder,
              size: TextSize.small,
              style: TextStyle(
                color: selected ? CColors.primaryColor : theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
        if (error != null) ...[
          const SizedBox(height: 6),
          CText.body(
            error!,
            size: TextSize.small,
            style: TextStyle(color: AppColors.errorColor),
          ),
        ],
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: child,
        ),
      ],
    );
  }
}
