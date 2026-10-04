import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/profile_manager/presentation/pages/profile_editor_dialog.dart';

import 'package:xray/features/settings/presentation/pages/options_dialog.dart';
import 'package:xray/features/settings/presentation/pages/routing_dialog.dart';
import 'package:xray/features/menu_bar/buttons/connect_button.dart';
import 'package:xray/features/menu_bar/buttons/reload_button.dart';

class CustomMenuBar extends ConsumerWidget {
  const CustomMenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(context).copyWith(
        menuBarTheme: MenuBarThemeData(
          style: MenuStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.all(5.0)),
          ),
        ),
        menuButtonTheme: const MenuButtonThemeData(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(15.0)),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: MenuBar(
              children: [
                SubmenuButton(
                  menuChildren: [
                    const MenuItemButton(
                      leadingIcon: Icon(Icons.content_paste_go),
                      child: Text('Import from clipboard'),
                    ),
                    const MenuItemButton(
                      leadingIcon: Icon(Icons.qr_code_scanner),
                      child: Text('Scan QR-code from image'),
                    ),
                    MenuItemButton(
                      leadingIcon: const Icon(Icons.note_add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            // title: const Text('Add server'),
                            content: ProfileEditorDialog(),
                          ),
                        );
                        // server.add(
                        //   Server(
                        //     name: 'Test Server',
                        //     address: 'example.com',
                        //     port: 443,
                        //     // uuid: 'your-uuid-here',
                        //   ),
                        // );
                      },
                      child: const Text('Add configuration manually'),
                    ),
                  ],
                  child: const Text('Add configuration'),
                ),
                const SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: Icon(Icons.edit),
                      child: Text('Edit groups'),
                    ),
                    MenuItemButton(
                      leadingIcon: Icon(Icons.cloud_sync),
                      child: Text('Update groups'),
                    ),
                    // MenuItemButton(
                    //   leadingIcon: Icon(Icons.update),
                    //   child: Text('Update subscriptions with proxy'),
                    // ),
                  ],
                  child: Text('Groups'),
                ),
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: const Icon(Icons.settings),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const OptionsDialog(),
                      ),
                      child: const Text('Options'),
                    ),
                    MenuItemButton(
                      leadingIcon: const Icon(Icons.route),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const RoutingDialog(),
                      ),
                      child: const Text('Routing'),
                    ),
                    const MenuItemButton(
                      leadingIcon: Icon(Icons.dns),
                      child: Text('DNS'),
                    ),
                    const MenuItemButton(
                      leadingIcon: Icon(Icons.public),
                      child: Text('Regional routing presets'),
                    ),
                    const Divider(),
                    const MenuItemButton(
                      leadingIcon: Icon(Icons.update),
                      child: Text('Check updates'),
                    ),
                    const Divider(),
                    const MenuItemButton(
                      leadingIcon: Icon(Icons.folder),
                      child: Text('Open install folder'),
                    ),
                  ],
                  child: const Text('Settings'),
                ),
                const SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: Icon(Icons.info),
                      child: Text('About'),
                    ),
                    MenuItemButton(
                      leadingIcon: Icon(Icons.developer_board),
                      child: Text('Supported protocols'),
                    ),
                  ],
                  child: Text('Help'),
                ),
                const ReloadButton(),
                const ConnectButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
