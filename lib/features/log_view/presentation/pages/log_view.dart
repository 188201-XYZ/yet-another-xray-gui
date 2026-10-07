import 'package:material_ui/material_ui.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/widgets/clear_logs_button.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/widgets/copy_logs_button.dart';

import 'package:yet_another_xray_gui/features/log_view/presentation/widgets/log_list.dart';
import 'package:yet_another_xray_gui/features/log_view/presentation/widgets/logs_search_field.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Divider(),
        SizedBox(
          height: 48,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                LogsSearchField(),
                Spacer(),
                CopyLogsButton(),
                ClearLogsButton(),
              ],
            ),
          ),
        ),
        Divider(),
        LogList(),
      ],
    );
  }
}
