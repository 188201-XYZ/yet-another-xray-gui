import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xray/features/log_view/domain/log_entry.dart';
import 'package:xray/features/log_view/presentation/providers/log_list_provider.dart';

class LogList extends ConsumerStatefulWidget {
  const LogList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogListState();
}

class _LogListState extends ConsumerState<LogList> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () => _updateBottomState(_scrollController.position),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateBottomState(ScrollMetrics metrics) {
    final isAtBottom = metrics.extentAfter <= 24;
    if (_isAtBottom != isAtBottom) {
      setState(() => _isAtBottom = isAtBottom);
    }
  }

  void _scrollToBottom({bool animated = false}) {
    if (!_scrollController.hasClients) return;

    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    if (animated) {
      _scrollController.animateTo(
        maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<List<LogEntry>>(logListProvider, (previous, next) {
      final shouldFollow =
          !_scrollController.hasClients ||
          _scrollController.position.extentAfter <= 24;
      if (shouldFollow) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _scrollToBottom();
        });
      }
    });

    final List<LogEntry> logList =
        ref.watch(filteredLogListProvider) ?? ref.watch(logListProvider);

    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        _updateBottomState(notification.metrics);
        return false;
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 3.5,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SelectionArea(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: logList.length,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isOdd
                          ? Color.lerp(
                              Theme.of(context).colorScheme.surface,
                              Theme.of(context).colorScheme.surfaceTint,
                              0.05,
                            )
                          : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Text(logList[index].text)),
                        const SelectionContainer.disabled(
                          child: SizedBox(width: 4),
                        ),
                        SelectionContainer.disabled(
                          child: Text('[${logList[index].id}]'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          if (!_isAtBottom)
            Positioned(
              bottom: 8,
              right: 12,
              child: Tooltip(
                message: 'Scroll to the bottom',
                child: FloatingActionButton.small(
                  onPressed: () => _scrollToBottom(animated: true),
                  child: const Icon(Icons.arrow_downward),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
