import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yet_another_xray_gui/core/constants/main.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/pages/profile_editor_dialog.dart';

import 'package:yet_another_xray_gui/features/settings/presentation/pages/options_dialog.dart';
import 'package:yet_another_xray_gui/features/settings/presentation/pages/routing_dialog.dart';
import 'package:yet_another_xray_gui/features/menu_bar/buttons/connect_button.dart';
import 'package:yet_another_xray_gui/features/menu_bar/buttons/reload_button.dart';

class CustomMenuBar extends ConsumerStatefulWidget {
  const CustomMenuBar({super.key});

  @override
  ConsumerState<CustomMenuBar> createState() => _CustomMenuBarState();
}

class _CustomMenuBarState extends ConsumerState<CustomMenuBar>
    with WindowListener {
  bool _maximized = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.isMaximized().then(
      (value) => setState(() => _maximized = value),
    );
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() => setState(() => _maximized = true);

  @override
  void onWindowUnmaximize() => setState(() => _maximized = false);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        menuBarTheme: MenuBarThemeData(
          style: MenuStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            elevation: WidgetStateProperty.all(0),
          ),
        ),
        menuButtonTheme: const MenuButtonThemeData(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(15.0)),
          ),
        ),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 3,
        child: SizedBox(
          height: 48,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
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
              const Expanded(
                child: DragToMoveArea(child: Center(child: Text(APP_NAME))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Button(
                      icon: Icons.minimize,
                      onPressed: () async => await windowManager.minimize(),
                    ),
                    _Button(
                      icon: !_maximized ? Icons.unfold_more : Icons.unfold_less,
                      onPressed: () async {
                        if (_maximized) {
                          await windowManager.unmaximize();
                        } else {
                          await windowManager.maximize();
                        }
                      },
                    ),
                    _Button(
                      icon: Icons.close,
                      onPressed: () async => await windowManager.close(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.icon, required this.onPressed});

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const _InsetRectangleBorder(5),
      splashFactory: NoSplash.splashFactory,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(height: 40, width: 40, child: Icon(icon)),
      ),
    );
  }
}

class _InsetRectangleBorder extends ShapeBorder {
  const _InsetRectangleBorder(this.inset);

  final double inset;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect.deflate(inset));

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => _InsetRectangleBorder(inset * t);
}
