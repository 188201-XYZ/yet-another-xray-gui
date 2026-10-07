import 'package:material_ui/material_ui.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/add_new_group_button.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/check_proxy_latency_button.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/check_proxy_speed_button.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/edit_group_button.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/group_list.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/profile_list.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/servers_search_field.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/widgets/update_group_subscription_button.dart';

class ProfileManager extends StatelessWidget {
  const ProfileManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            // padding: EdgeInsetsGeometry.all(8.0),
            child: SizedBox(
              height: 48.0,
              child: Row(
                spacing: 8.0,
                children: [
                  ServersSearchField(),
                  VerticalDivider(),
                  CheckProxyLatencyButton(),
                  CheckProxySpeedButton(),
                  VerticalDivider(),
                  AddNewGroupButton(),
                  EditGroupButton(),
                  UpdateGroupSubscriptionButton(),
                  VerticalDivider(),
                  GroupList(),
                ],
              ),
            ),
          ),
          Divider(),
          ProfileList(),
        ],
      ),
    );
  }
}
