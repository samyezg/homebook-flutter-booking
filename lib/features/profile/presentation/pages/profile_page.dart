import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:homebook_app/app/config/app_environment_provider.dart';
import 'package:homebook_app/app/router/app_routes.dart';
import 'package:homebook_app/app/theme/app_colors.dart';
import 'package:homebook_app/app/theme/app_tokens.dart';
import 'package:homebook_app/features/auth/presentation/auth_notifier.dart';
import 'package:homebook_app/features/profile/domain/app_role.dart';
import 'package:homebook_app/features/profile/presentation/role_notifier.dart';
import 'package:homebook_app/l10n/l10n_ext.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final role = ref.watch(appRoleProvider);
    final user = ref.watch(authProvider);
    final env = ref.watch(appEnvironmentProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.account,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (user == null)
            ListTile(
              key: const ValueKey('open-sign-in'),
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.login_rounded),
              title: Text(l10n.signInOrSignUp),
              subtitle: Text(l10n.signInToSaveBookings),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(AppRoutes.signIn),
            )
          else ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_outline),
              title: Text(user.email),
              subtitle: Text(
                env.useSupabase ? l10n.signedIn : l10n.guestSession,
                style: const TextStyle(fontFamily: AppFonts.secondary),
              ),
            ),
            if (env.useSupabase)
              ListTile(
                key: const ValueKey('sync-cloud'),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.cloud_sync_outlined),
                title: Text(l10n.syncNow),
                onTap: () async {
                  await ref.read(authProvider.notifier).syncFromCloud();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.l10n.syncRefreshed)),
                  );
                },
              ),
            ListTile(
              key: const ValueKey('sign-out'),
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout_rounded),
              title: Text(l10n.signOut),
              onTap: () => ref.read(authProvider.notifier).signOut(),
            ),
          ],
          const Divider(),
          Text(
            l10n.currentRole,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<AppRole>(
            key: const ValueKey('role-switch'),
            segments: [
              for (final value in AppRole.values)
                ButtonSegment(
                  value: value,
                  label: Text(l10n.appRoleLabel(value)),
                  icon: Icon(
                    value == AppRole.user
                        ? Icons.person_outline
                        : Icons.handyman_outlined,
                  ),
                ),
            ],
            selected: {role},
            onSelectionChanged: (next) {
              ref.read(appRoleProvider.notifier).setRole(next.first);
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.roleHint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: AppFonts.secondary,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (role == AppRole.provider)
            ListTile(
              key: const ValueKey('open-provider-home'),
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.dashboard_outlined),
              title: Text(l10n.providerWorkbench),
              subtitle: Text(l10n.providerWorkbenchSubtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.push(AppRoutes.providerHome),
            )
          else
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.switchToProvider),
              subtitle: Text(l10n.switchToProviderHint),
            ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.payment),
            subtitle: Text(l10n.paymentPayOnSite),
          ),
        ],
      ),
    );
  }
}
