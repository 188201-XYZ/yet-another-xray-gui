import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart'
    show TextInputFormatter, FilteringTextInputFormatter;

import 'package:yet_another_xray_gui/features/profile_manager/domain/dto/profile_group_dto.dart';

class GroupEditorDialog extends StatefulWidget {
  const GroupEditorDialog({super.key, this.groupDto});

  final ProfileGroupDTO? groupDto;

  @override
  State<GroupEditorDialog> createState() => _GroupEditorDialogState();
}

class _GroupEditorDialogState extends State<GroupEditorDialog> {
  final _formKey = GlobalKey<FormState>();

  late ProfileGroupDTO _groupDto;

  bool get _hasSubscriptionUrl => _groupDto.subscriptionURL != null;
  bool get _subscriptionAutoUpdate => _groupDto.enableAutoUpdate;
  bool get isNew => widget.groupDto == null;

  @override
  void initState() {
    super.initState();
    _groupDto = widget.groupDto ?? ProfileGroupDTO();
  }

  void _saveForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    Navigator.pop(context, _groupDto);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          isNew ? 'Create a profile group' : 'Edit the profile group',
          // style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => _saveForm(context),
          child: Text(isNew ? 'Create' : 'Save'),
        ),
      ],
      content: SizedBox(
        width: 400.0,
        height: MediaQuery.heightOf(context) / 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      // border: OutlineInputBorder(),
                      labelText: 'Group Name',
                      // counterText: 'Required',
                      helperText: '',
                      hintText: 'my group',
                    ),
                    initialValue: isNew ? 'New Group' : _groupDto.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Required' : null,
                    onSaved: (value) {
                      final trimmedName = (value ?? '').trim();
                      _groupDto = _groupDto.copyWith(
                        name: trimmedName.isNotEmpty
                            ? trimmedName
                            : 'invalidname',
                      );
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      // border: OutlineInputBorder(),
                      labelText: 'Subscription URL',
                      counterText: 'Optional',
                      helperText: '',
                      hintText: 'https://example.com/sub/786d64f',
                    ),
                    initialValue: isNew
                        ? ''
                        : (_groupDto.subscriptionURL?.toString() ?? ''),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (value.startsWith('https')) return null;
                      // dart format off
                      if (value.startsWith('http')) return 'Plain HTTP is insecure';
                      return 'Unsupported scheme';
                    },
                    onSaved: (value) {
                      _groupDto = _groupDto.copyWith(
                        subscriptionURL: value == null || value.isEmpty
                            ? null
                            : Uri.parse(value),
                      );
                    },
                  ),
                  FormField<bool>(
                    initialValue: _subscriptionAutoUpdate,
                    onSaved: (value) {
                      _groupDto = _groupDto.copyWith(
                        enableAutoUpdate: value ?? false,
                      );
                    },
                    builder: (state) => Tooltip(
                      message: _hasSubscriptionUrl
                          ? ''
                          : 'No subscription URL specified',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SwitchListTile(
                          title: const Text(
                            'Enable subscription auto\u2011update',
                          ),
                          subtitle: const Text(
                            'Should the subscription be updated automatically in the background',
                          ),
                          contentPadding: EdgeInsets.zero,
                          value: state.value ?? false,
                          onChanged: !_hasSubscriptionUrl
                              ? null
                              : (value) {
                                  state.didChange(value);
                                  setState(() {
                                    _groupDto = _groupDto.copyWith(
                                      enableAutoUpdate: value,
                                    );
                                  });
                                },
                        ),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: _subscriptionAutoUpdate && _hasSubscriptionUrl
                        ? ''
                        : 'Subscription auto-update is disabled',
                    child: TextFormField(
                      decoration: const InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Subscription auto-update interval',
                        counterText: 'In minutes',
                        helperText: '',
                        hintText: '360',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      enabled: _subscriptionAutoUpdate && _hasSubscriptionUrl,
                      initialValue: isNew
                          ? '360'
                          : _groupDto.autoUpdateInterval.toString(),
                      autovalidateMode:
                          AutovalidateMode.onUserInteractionIfError,
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Required' : null,
                      onSaved: (value) {
                        final parsed = int.tryParse(value ?? '');
                        _groupDto = _groupDto.copyWith(
                          autoUpdateInterval: parsed ?? 360,
                        );
                      },
                    ),
                  ),

                  // FormField<double>(
                  //   initialValue: 1,
                  //   builder: (state) => Column(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: [
                  //       Text(
                  //         'Subscription auto-update interval',
                  //         style: Theme.of(context).textTheme.bodySmall
                  //             ?.copyWith(
                  //               color: Theme.of(
                  //                 context,
                  //               ).colorScheme.onSurfaceVariant,
                  //             ),
                  //         textAlign: TextAlign.start,
                  //       ),
                  //       Slider(
                  //         label:
                  //             '${state.value.toString().split('.')[0]} hours',
                  //         divisions: 23,
                  //         min: 1,
                  //         max: 24,
                  //         year2023: false,
                  //         value: state.value ?? 1,
                  //         onChanged: (v) => state.didChange(v),
                  //       ),
                  //       Text(
                  //         'In hours',
                  //         style: Theme.of(context).textTheme.bodySmall
                  //             ?.copyWith(
                  //               color: Theme.of(
                  //                 context,
                  //               ).colorScheme.onSurfaceVariant,
                  //             ),
                  //         textAlign: TextAlign.end,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
