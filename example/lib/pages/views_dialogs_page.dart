import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

enum _OrderStatus { processing, shipped, delivered }

class _Order {
  const _Order({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });

  final String id;
  final String title;
  final String amount;
  final String date;
  final _OrderStatus status;

  String get statusLabel => switch (status) {
        _OrderStatus.processing => 'Processing',
        _OrderStatus.shipped => 'Shipped',
        _OrderStatus.delivered => 'Delivered',
      };
}

class ViewsDialogsPage extends StatefulWidget {
  const ViewsDialogsPage({super.key});

  @override
  State<ViewsDialogsPage> createState() => _ViewsDialogsPageState();
}

class _ViewsDialogsPageState extends State<ViewsDialogsPage> {
  static const _orders = [
    _Order(
      id: '#1042',
      title: 'Studio desk lamp',
      amount: '\$129.00',
      date: 'May 12, 2026',
      status: _OrderStatus.shipped,
    ),
    _Order(
      id: '#1038',
      title: 'Ergonomic chair',
      amount: '\$349.00',
      date: 'May 8, 2026',
      status: _OrderStatus.processing,
    ),
    _Order(
      id: '#1021',
      title: 'Monitor stand',
      amount: '\$59.00',
      date: 'Apr 28, 2026',
      status: _OrderStatus.delivered,
    ),
    _Order(
      id: '#1015',
      title: 'Wireless keyboard',
      amount: '\$89.00',
      date: 'Apr 19, 2026',
      status: _OrderStatus.delivered,
    ),
  ];

  final Set<_OrderStatus> _activeFilters = {
    _OrderStatus.processing,
    _OrderStatus.shipped,
    _OrderStatus.delivered,
  };

  List<_Order> get _visibleOrders =>
      _orders.where((order) => _activeFilters.contains(order.status)).toList();

  void _showFilterSheet() {
    final draft = Set<_OrderStatus>.from(_activeFilters);

    showCModalBottomSheet(
      context: context,
      icon: Icons.tune_outlined,
      title: 'Filter orders',
      subtitle: 'Show orders by status.',
      body: StatefulBuilder(
        builder: (context, setSheetState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final status in _OrderStatus.values)
                _FilterOption(
                  label: _labelForStatus(status),
                  selected: draft.contains(status),
                  onChanged: (selected) {
                    setSheetState(() {
                      if (selected) {
                        draft.add(status);
                      } else if (draft.length > 1) {
                        draft.remove(status);
                      }
                    });
                  },
                ),
            ],
          );
        },
      ),
      actions: [
        CPopupAction(
          label: 'Clear all',
          style: CPopupActionStyle.outlined,
          onPressed: () {
            setState(() {
              _activeFilters
                ..clear()
                ..addAll(_OrderStatus.values);
            });
          },
        ),
        CPopupAction(
          label: 'Apply',
          onPressed: () {
            setState(() {
              _activeFilters
                ..clear()
                ..addAll(draft);
            });
            CToast.of(context).showMessage(
              title: 'Filters updated',
              variant: CToastVariant.success,
            );
          },
        ),
      ],
    );
  }

  void _showMoreOptionsSheet() {
    showCModalBottomSheet(
      context: context,
      icon: Icons.more_horiz,
      title: 'Order actions',
      subtitle: 'What would you like to do?',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetActionTile(
            icon: Icons.receipt_long_outlined,
            label: 'Download invoice',
            onTap: () {
              Navigator.of(context).pop();
              CToast.of(context).showMessage(
                title: 'Invoice ready',
                variant: CToastVariant.success,
              );
            },
          ),
          _SheetActionTile(
            icon: Icons.support_agent_outlined,
            label: 'Contact support',
            onTap: () {
              Navigator.of(context).pop();
              CToast.of(context).showMessage(
                title: 'Support notified',
                variant: CToastVariant.info,
              );
            },
          ),
          _SheetActionTile(
            icon: Icons.undo_outlined,
            label: 'Request return',
            onTap: () {
              Navigator.of(context).pop();
              CToast.of(context).showMessage(
                title: 'Return started',
                variant: CToastVariant.warning,
              );
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    showCPopup(
      context: context,
      icon: Icons.warning_amber_rounded,
      title: 'Delete account?',
      subtitle: 'This permanently removes your profile and order history.',
      body: CText.body(
        'You will lose access to saved addresses, wishlists, and active subscriptions. This action cannot be undone.',
        size: TextSize.small,
      ),
      actions: [
        CPopupAction(
          label: 'Keep account',
          style: CPopupActionStyle.outlined,
          onPressed: () {},
        ),
        CPopupAction(
          label: 'Delete account',
          onPressed: () {
            CToast.of(context).showMessage(
              title: 'Account scheduled for deletion',
              variant: CToastVariant.warning,
            );
          },
        ),
      ],
    );
  }

  static String _labelForStatus(_OrderStatus status) => switch (status) {
        _OrderStatus.processing => 'Processing',
        _OrderStatus.shipped => 'Shipped',
        _OrderStatus.delivered => 'Delivered',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orders = _visibleOrders;

    return CustomScaffold(
      title: demoScaffoldTitle('Dialogs'),
      action: IconButton(
        tooltip: 'Filter orders',
        onPressed: _showFilterSheet,
        icon: Icon(
          Icons.filter_list,
          color: theme.colorScheme.onSurface,
        ),
      ),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
          children: [
            _AccountSummary(theme: theme),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CText.label('Your orders', size: TextSize.small),
                ),
                CText.body(
                  '${orders.length} shown',
                  size: TextSize.small,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (orders.isEmpty)
              _EmptyOrdersState(onClearFilters: () {
                setState(() {
                  _activeFilters
                    ..clear()
                    ..addAll(_OrderStatus.values);
                });
              })
            else
              for (var i = 0; i < orders.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _OrderCard(
                  order: orders[i],
                  theme: theme,
                  onMore: _showMoreOptionsSheet,
                ),
              ],
            const SizedBox(height: 28),
            CText.label('Account', size: TextSize.small),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.all(AppRadius.l),
                boxShadow: AppShadow.sm,
                border: Border.all(
                  color: AppColors.errorColor.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CText.body('Danger zone', size: TextSize.small),
                  const SizedBox(height: 6),
                  CText.body(
                    'Deleting your account removes all personal data from our store.',
                    size: TextSize.small,
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CButton.outlined(
                    onPressed: _confirmDeleteAccount,
                    child: CText.label(
                      'Delete account',
                      style: const TextStyle(color: AppColors.errorColor),
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

class _AccountSummary extends StatelessWidget {
  const _AccountSummary({required this.theme});

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
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: CGradient.primaryToSecondary,
            ),
            child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 28),
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
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.theme,
    required this.onMore,
  });

  final _Order order;
  final ThemeData theme;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (order.status) {
      _OrderStatus.processing => AppColors.warningColor,
      _OrderStatus.shipped => CColors.primaryColor,
      _OrderStatus.delivered => AppColors.successColor,
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.l),
        boxShadow: AppShadow.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CText.label(order.id, size: TextSize.small),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: const BorderRadius.all(AppRadius.s),
                      ),
                      child: CText.label(
                        order.statusLabel,
                        size: TextSize.small,
                        style: TextStyle(color: statusColor, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                CText.body(order.title, size: TextSize.small),
                const SizedBox(height: 4),
                CText.body(
                  '${order.date} · ${order.amount}',
                  size: TextSize.small,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'More options',
            onPressed: onMore,
            icon: const Icon(Icons.more_vert),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.label,
    required this.selected,
    required this.onChanged,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!selected),
      borderRadius: const BorderRadius.all(AppRadius.s),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(child: CText.body(label, size: TextSize.small)),
            Checkbox(
              value: selected,
              onChanged: (value) => onChanged(value ?? false),
              activeColor: CColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetActionTile extends StatelessWidget {
  const _SheetActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(AppRadius.s),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: CColors.secondaryColor),
            const SizedBox(width: 14),
            Expanded(child: CText.body(label, size: TextSize.small)),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.45),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyOrdersState extends StatelessWidget {
  const _EmptyOrdersState({required this.onClearFilters});

  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.l),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 40,
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          CText.body('No orders match your filters', size: TextSize.small),
          const SizedBox(height: 16),
          CButton.elevated(
            onPressed: onClearFilters,
            child: CText.label('Show all orders'),
          ),
        ],
      ),
    );
  }
}
