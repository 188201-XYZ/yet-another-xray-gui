import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_xray_gui/features/profile_manager/presentation/providers/profile_list_provider.dart';

class ProfileList extends ConsumerWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupList = ref.watch(groupListProvider);

    return Expanded(
      child: IndexedStack(
        index: groupList.indexWhere(
          (element) => element.id == ref.watch(groupSelectionProvider),
        ),
        children: List<Widget>.generate(
          groupList.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: groupList[index].profiles.length,
              itemBuilder: (context, innerIndex) => Row(
                children: [Text(groupList[index].profiles[innerIndex].name)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// DataRow(cells: List<DataCell>.generate(columns.length, (index)))

// class ServerList extends ConsumerWidget {
//   const ServerList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final server = ref.watch(serverProvider);
//     final serverRead = ref.read(serverProvider.notifier);

//     return Material(
//       type: MaterialType.transparency,
//       child: ListView.builder(
//         itemCount: server.servers.length,
//         itemBuilder: (_, index) {
//           final currentServer = server.servers[index];
//           return ListTile(
//             dense: true,
//             title: Text(currentServer.name),
//             subtitle: Text('${currentServer.address}:${currentServer.port}'),
//             selected: server.selected == currentServer,
//             onTap: () {
//               serverRead.select(currentServer);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// return Expanded(
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//         child: SingleChildScrollView(
//           child: DataTable(
//             dataRowMinHeight: 32,
//             dataRowMaxHeight: 32,
//             headingRowHeight: 32,
//             border: TableBorder(
//               horizontalInside: BorderSide(width: 0.1),
//               // verticalInside: BorderSide(width: 0.3),
//             ),
//             columns: List<DataColumn>.generate(
//               columns.length,
//               (index) => DataColumn(label: Text(columns[index])),
//             ),
//             rows: List<DataRow>.generate(
//               servers.length,
//               (index) => DataRow(
//                 selected: serverProv.selected == servers[index],
//                 onSelectChanged: (value) => ref
//                     .read(serverProvider.notifier)
//                     .select(servers[index]),
//                 cells: <DataCell>[
//                   DataCell(Text(index.toString())),
//                   DataCell(Text(servers[index].name)),
//                   DataCell(Text(servers[index].address)),
//                   DataCell(Text(servers[index].port.toString())),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// );
