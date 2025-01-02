import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'customdialog_about.dart';
import 'custom_logout_dialog.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildListTile(
            context,
            icon: Icons.import_contacts,
            title: l10n.appTitle,
            onTap: () => Navigator.pop(context),
          ),
          _buildCustomDivider(),
          _buildListTile(
            context,
            icon: Icons.share,
            title: l10n.appShare,
            onTap: () {
              Share.share(
                l10n.share_message,
                subject: l10n.share_subject,
              );
            },
          ),
          _buildCustomDivider(),
          _buildListTile(
            context,
            icon: Icons.info_outline,
            title: l10n.appAbout,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    message: l10n.about_message,
                    title: l10n.appAbout,
                    icon: Icons.info_outline,
                    onClose: () => Navigator.pop(context),

                  );
                },
              );
            },
          ),
          _buildCustomDivider(),
          _buildListTile(
            context,
            icon: Icons.help_outline,
            title: l10n.title_help,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    message: l10n.message_help,
                    title: l10n.title_help,
                    icon: Icons.live_help_rounded,
                    onClose: () => Navigator.pop(context),

                  );
                },
              );
            },
          ),
          _buildCustomDivider(),
          _buildListTile(
            context,
            icon: Icons.logout,
            title: l10n.logout,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomLogoutDialog(
                    message: l10n.logout,
                    title: l10n.logout,
                    context,
                    onLogout: () {
                      Navigator.pop(context); // Close the dialog
                      SystemNavigator.pop(); // Exit the app
                    },
                    onCancel: () {
                      Navigator.pop(context); // Close the dialog
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _buildDrawerHeader() {
    return const DrawerHeader(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/logo-ar.webp'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDivider() {
    return const Divider(
      thickness: 0.8,
      height: 5,
      indent: 0,
      endIndent: 0,
    );
  }

  Widget _buildListTile(BuildContext context,
      {
        required IconData icon,
        required String title,
        required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),

      title: Text(
        title,
      ),
      onTap: onTap,
    );
  }
}
