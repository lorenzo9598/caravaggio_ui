import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    CToast.of(context).showMessage(
      title: 'Signed in',
      variant: CToastVariant.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7);

    return CustomScaffold(
      title: demoScaffoldTitle('Login'),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
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
                          child: const Icon(Icons.lock_outline, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText.headline('Welcome back', size: TextSize.small),
                              const SizedBox(height: 4),
                              CText.body(
                                'Enter your credentials to continue',
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
                          CText.label('Account', size: TextSize.small),
                          const SizedBox(height: 12),
                          CTextField.filled(
                            controller: _emailController,
                            decoration: const CFieldDecoration(
                              labelText: 'Email',
                              hintText: 'you@company.com',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your email';
                              }
                              return null;
                            },
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 14),
                          CTextField.filled(
                            controller: _passwordController,
                            decoration: const CFieldDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              labelIcon: Icon(Icons.lock_outline, color: Color(0xFF6B7280)),
                            ),
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 20),
                          CButton.elevated(
                            onPressed: _onSignIn,
                            child: CText.label('Sign in'),
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
