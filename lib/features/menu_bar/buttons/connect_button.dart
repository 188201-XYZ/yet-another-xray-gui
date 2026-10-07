import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/providers/profile_list_provider.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/providers/xray_core_provider.dart';

class ConnectButton extends ConsumerWidget {
  const ConnectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuItemButton(
      onPressed: () {
        if (ref.watch(profileSelectionProvider) != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No server is selected')),
          );
        } else {
          !ref.watch(xrayCoreStateProvider)
              ? ref.read(xrayCoreStateProvider.notifier).startProcess()
              : ref.read(xrayCoreStateProvider.notifier).stopProcess();
        }
      },
      child: Text(!ref.watch(xrayCoreStateProvider) ? 'Connect' : 'Disconnect'),
    );

    // final core = ref.watch(coreProvider);
    // final coreRead = ref.read(coreProvider.notifier);

    // return MenuItemButton(
    //   onPressed: () {
    //     if (ref.watch(serverProvider).selected == null) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('No server is selected')),
    //       );
    //     } else {
    //       ![
    //             ConnectionStatus.connected,
    //             ConnectionStatus.connecting,
    //           ].contains(core.status)
    //           ? coreRead.connect()
    //           : coreRead.disconnect();
    //     }
    //   },
    //   child: Text(
    //     ![
    //           ConnectionStatus.connected,
    //           ConnectionStatus.connecting,
    //         ].contains(core.status)
    //         ? 'Connect'
    //         : 'Disconnect',
    //   ),
    // );
  }
}
