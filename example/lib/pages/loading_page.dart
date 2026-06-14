import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _loading = false;
  bool _emailNotifications = true;
  bool _marketingEmails = false;

  final _nameController = TextEditingController(text: 'Alex Morgan');
  final _bioController = TextEditingController(text: 'Product designer at Studio North');

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_loading) return;
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _loading = false);
    CToast.of(context).showMessage(
      title: 'Profile updated',
      variant: CToastVariant.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      showAppDrawer: false,
      backToHome: true,
      title: demoScaffoldTitle('Loading'),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
          children: [
            CWrapper(
              loading: _loading,
              message: _loading ? 'Saving your changes…' : null,
              borderRadius: const BorderRadius.all(AppRadius.l),
              loader: CLoader.orbit(
                color: CColors.secondaryColor,
                numberOfDots: 5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: const BorderRadius.all(AppRadius.l),
                  boxShadow: AppShadow.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfileHeader(theme: theme),
                    Divider(
                      height: 1,
                      color: CColors.secondary.shade200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CText.label('Profile', size: TextSize.small),
                          const SizedBox(height: 12),
                          CTextField.filled(
                            controller: _nameController,
                            decoration: const CFieldDecoration(
                              labelText: 'Display name',
                              hintText: 'Your name',
                            ),
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 12),
                          CTextField.filled(
                            controller: _bioController,
                            decoration: const CFieldDecoration(
                              labelText: 'Bio',
                              hintText: 'Short description',
                            ),
                            maxLines: 2,
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 20),
                          CText.label('Preferences', size: TextSize.small),
                          const SizedBox(height: 8),
                          _SettingRow(
                            title: 'Email notifications',
                            subtitle: 'Order updates and receipts',
                            value: _emailNotifications,
                            onChanged: (value) => setState(() => _emailNotifications = value),
                          ),
                          _SettingRow(
                            title: 'Marketing emails',
                            subtitle: 'Tips, offers, and news',
                            value: _marketingEmails,
                            onChanged: (value) => setState(() => _marketingEmails = value),
                          ),
                          const SizedBox(height: 20),
                          CButton.elevated(
                            onPressed: _loading ? null : _saveChanges,
                            child: CText.label(_loading ? 'Saving…' : 'Save changes'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: CGradient.primaryToSecondary,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText.headline('Alex Morgan', size: TextSize.small),
                const SizedBox(height: 4),
                CText.body(
                  'alex.morgan@example.com',
                  size: TextSize.small,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText.body(title, size: TextSize.small),
                const SizedBox(height: 2),
                CText.body(
                  subtitle,
                  size: TextSize.small,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: CColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
