import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/features/auth/domain/auth_exception.dart';
import 'package:homebook_app/features/auth/domain/auth_validators.dart';
import 'package:homebook_app/features/auth/presentation/auth_notifier.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _emailError;
  String? _passwordError;
  String? _formError;
  var _submitting = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final emailError = AuthValidators.emailError(_email.text, l10n);
    final passwordError = AuthValidators.passwordError(_password.text, l10n);
    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
      _formError = null;
    });
    if (emailError != null || passwordError != null) return;

    setState(() => _submitting = true);
    try {
      await ref.read(authProvider.notifier).signIn(
            email: _email.text,
            password: _password.text,
          );
      if (!mounted) return;
      context.go(AppRoutes.profile);
    } on AuthException catch (error) {
      setState(() => _formError = error.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.signInTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.welcomeTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.signInSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.secondary,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            key: const ValueKey('sign-in-email'),
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: l10n.email,
              errorText: _emailError,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            key: const ValueKey('sign-in-password'),
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              labelText: l10n.password,
              errorText: _passwordError,
            ),
          ),
          if (_formError != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _formError!,
              style: const TextStyle(color: AppColors.statusCancelled),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            key: const ValueKey('sign-in-submit'),
            onPressed: _submitting ? null : _submit,
            child: Text(_submitting ? l10n.signingIn : l10n.signIn),
          ),
          TextButton(
            key: const ValueKey('go-sign-up'),
            onPressed: () => context.push(AppRoutes.signUp),
            child: Text(l10n.noAccountSignUp),
          ),
        ],
      ),
    );
  }
}
