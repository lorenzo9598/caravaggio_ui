import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class ViewsTabsPage extends StatefulWidget {
  const ViewsTabsPage({super.key});

  @override
  State<ViewsTabsPage> createState() => _ViewsTabsPageState();
}

class _ViewsTabsPageState extends State<ViewsTabsPage> {
  bool _emailNotifications = true;
  bool _twoFactor = true;
  bool _publicProfile = false;

  static const _overviewStats = [
    ('Projects', '12'),
    ('Tasks done', '148'),
    ('Hours', '320'),
  ];

  static const _activities = [
    ('Updated profile photo', '2 hours ago'),
    ('Completed "Q2 roadmap" task', 'Yesterday'),
    ('Joined team "Studio North"', '3 days ago'),
    ('Changed password', 'Last week'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      showAppDrawer: false,
      backToHome: true,
      title: demoScaffoldTitle('Tabs'),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
          children: [
            _AccountHeader(theme: theme),
            const SizedBox(height: 20),
            CTabs(
              tabs: const [
                CTabItem(label: 'Overview', icon: Icons.dashboard_outlined),
                CTabItem(label: 'Activity', icon: Icons.history_outlined),
                CTabItem(label: 'Settings', icon: Icons.settings_outlined),
              ],
              children: [
                _OverviewTab(stats: _overviewStats, theme: theme),
                _ActivityTab(activities: _activities, theme: theme),
                _SettingsTab(
                  emailNotifications: _emailNotifications,
                  twoFactor: _twoFactor,
                  publicProfile: _publicProfile,
                  onEmailChanged: (value) => setState(() => _emailNotifications = value),
                  onTwoFactorChanged: (value) => setState(() => _twoFactor = value),
                  onPublicProfileChanged: (value) => setState(() => _publicProfile = value),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AccountHeader extends StatelessWidget {
  const _AccountHeader({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.l),
        boxShadow: AppShadow.sm,
      ),
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
                const SizedBox(height: 6),
                CText.label('Member since Jan 2024', size: TextSize.small),
              ],
            ),
          ),
          CButton.outlined(
            onPressed: () {},
            child: CText.label('Edit', size: TextSize.small),
          ),
        ],
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({
    required this.stats,
    required this.theme,
  });

  final List<(String, String)> stats;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CText.label('This month', size: TextSize.small),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - 16) / 3;
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: stats
                  .map(
                    (stat) => SizedBox(
                      width: cardWidth.clamp(88, constraints.maxWidth),
                      child: _MiniStatCard(label: stat.$1, value: stat.$2, theme: theme),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 20),
        CText.label('Focus', size: TextSize.small),
        const SizedBox(height: 12),
        Center(
          child: CCircularIndicator.percent(
            value: CircularValue(currentValue: 68, maxValue: 100),
            currentLabel: 'Weekly goal',
            maxLabel: 'Target',
            isDense: true,
          ),
        ),
        const SizedBox(height: 16),
        CText.body(
          'You are on track to finish your sprint goals by Friday.',
          size: TextSize.small,
          style: TextStyle(
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.theme,
  });

  final String label;
  final String value;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CColors.primaryColor.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.all(AppRadius.m),
        border: Border.all(
          color: CColors.primaryColor.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(label, size: TextSize.small),
          const SizedBox(height: 4),
          CText.headline(value, size: TextSize.small),
        ],
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  const _ActivityTab({
    required this.activities,
    required this.theme,
  });

  final List<(String, String)> activities;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CText.label('Recent', size: TextSize.small),
        const SizedBox(height: 12),
        for (var i = 0; i < activities.length; i++) ...[
          if (i > 0)
            Divider(
              height: 1,
              color: CColors.secondary.shade200,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: CColors.secondaryColor.withValues(alpha: 0.12),
                    borderRadius: const BorderRadius.all(AppRadius.s),
                  ),
                  child: Icon(
                    Icons.timeline,
                    size: 18,
                    color: CColors.secondaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText.body(activities[i].$1, size: TextSize.small),
                      const SizedBox(height: 2),
                      CText.body(
                        activities[i].$2,
                        size: TextSize.small,
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab({
    required this.emailNotifications,
    required this.twoFactor,
    required this.publicProfile,
    required this.onEmailChanged,
    required this.onTwoFactorChanged,
    required this.onPublicProfileChanged,
  });

  final bool emailNotifications;
  final bool twoFactor;
  final bool publicProfile;
  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onTwoFactorChanged;
  final ValueChanged<bool> onPublicProfileChanged;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.65);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CText.label('Account', size: TextSize.small),
        const SizedBox(height: 8),
        _SettingRow(
          title: 'Email notifications',
          subtitle: 'Activity summaries and alerts',
          value: emailNotifications,
          onChanged: onEmailChanged,
          mutedColor: muted,
        ),
        _SettingRow(
          title: 'Two-factor authentication',
          subtitle: 'Extra sign-in protection',
          value: twoFactor,
          onChanged: onTwoFactorChanged,
          mutedColor: muted,
        ),
        _SettingRow(
          title: 'Public profile',
          subtitle: 'Visible to other team members',
          value: publicProfile,
          onChanged: onPublicProfileChanged,
          mutedColor: muted,
        ),
        const SizedBox(height: 16),
        CButton.elevated(
          onPressed: () {},
          child: CText.label('Save preferences'),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.mutedColor,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? mutedColor;

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
                  style: TextStyle(color: mutedColor),
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
