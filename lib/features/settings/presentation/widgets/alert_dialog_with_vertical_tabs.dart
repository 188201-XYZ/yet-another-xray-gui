import 'package:material_ui/material_ui.dart';

class AlertDialogWithVerticalTabs extends StatefulWidget {
  const AlertDialogWithVerticalTabs({
    super.key,
    required this.tabs,
    required this.children,
  });

  final List<String> tabs;
  final List<Widget> children;

  @override
  State<AlertDialogWithVerticalTabs> createState() =>
      _AlertDialogWithVerticalTabsState();
}

class _AlertDialogWithVerticalTabsState
    extends State<AlertDialogWithVerticalTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
      content: SizedBox(
        width: MediaQuery.widthOf(context) / 1.5,
        height: MediaQuery.heightOf(context) / 1.5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            spacing: 8.0,
            children: [
              IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(widget.tabs.length, (int index) {
                    bool isSelected = _selectedIndex == index;
                    return InkWell(
                      onTap: () {
                        if (!isSelected) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(widget.tabs[index])),
                      ),
                    );
                  }),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: IndexedStack(
                  sizing: StackFit.expand,
                  index: _selectedIndex,
                  children: widget.children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
