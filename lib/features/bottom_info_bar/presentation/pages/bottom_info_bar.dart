import 'package:material_ui/material_ui.dart';
import 'package:yet_another_xray_gui/features/bottom_info_bar/presentation/widgets/bandwidth_display.dart';
import 'package:yet_another_xray_gui/features/bottom_info_bar/presentation/widgets/profile_info.dart';
import 'package:yet_another_xray_gui/features/bottom_info_bar/presentation/widgets/proxy_mode_selector.dart';
import 'package:yet_another_xray_gui/features/bottom_info_bar/presentation/widgets/routing_profile_selector.dart';

class BottomInfoBar extends StatefulWidget {
  const BottomInfoBar({super.key});

  @override
  State<BottomInfoBar> createState() => _BottomInfoBarState();
}

class _BottomInfoBarState extends State<BottomInfoBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: 64.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            child: Row(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Listening on:'), Text('127.0.0.1:10808')],
                ),
                const VerticalDivider(width: 32),
                Row(
                  children: [
                    const Text('TUN Mode '),
                    Switch(
                      value: true,
                      thumbIcon: const WidgetStatePropertyAll(
                        Icon(Icons.vpn_key),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
                const VerticalDivider(width: 32),
                const ProxyModeSelector(),
                const SizedBox(width: 16),
                const RoutingProfileSelector(),
                const VerticalDivider(width: 32),
                const ProfileInfo(),
                const Spacer(),
                const BandwidthDisplay(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
