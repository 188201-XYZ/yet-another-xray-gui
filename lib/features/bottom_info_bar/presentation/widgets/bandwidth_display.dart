import 'package:material_ui/material_ui.dart';
import 'package:human_readable_formats/human_readable_formats.dart';

class BandwidthDisplay extends StatelessWidget {
  const BandwidthDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text('Proxy:'),
              const Spacer(),
              Text('${humanizeBandwidth(100000000000)} ↑'),
              const Text(' | '),
              Text('${humanizeBandwidth(100000000000)} ↓'),
            ],
          ),
          Row(
            children: [
              const Text('Direct:'),
              const Spacer(),
              Text('${humanizeBandwidth(100000000000)} ↑'),
              const Text(' | '),
              Text('${humanizeBandwidth(100000000000)} ↓'),
            ],
          ),
        ],
      ),
    );
  }
}
