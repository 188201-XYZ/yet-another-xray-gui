import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart'
    show TextInputFormatter, FilteringTextInputFormatter;

import 'package:xray/features/profile_manager/domain/dto/profile_group_dto.dart';

class GroupEditorDialog extends StatefulWidget {
  const GroupEditorDialog({super.key, this.groupDto});

  final ProfileGroupDTO? groupDto;

  @override
  State<GroupEditorDialog> createState() => _GroupEditorDialogState();
}

class _GroupEditorDialogState extends State<GroupEditorDialog> {
  final _formKey = GlobalKey<FormState>();

  late ProfileGroupDTO _groupDto;
  bool _hasSubscriptionUrl = false;
  bool _subscriptionAutoUpdate = false;

  @override
  void initState() {
    super.initState();
    _groupDto = widget.groupDto ?? ProfileGroupDTO();
    _hasSubscriptionUrl = _groupDto.subscriptionURL != null;
    _subscriptionAutoUpdate = _groupDto.enableAutoUpdate;
  }

  void _saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, _groupDto);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isNew = widget.groupDto == null;

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
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                    onSaved: (v) => setState(() {
                      final trimmedName = (v ?? '').trim();
                      _groupDto = _groupDto.copyWith(
                        name: trimmedName.isNotEmpty
                            ? trimmedName
                            : 'invalidname',
                      );
                    }),
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
                    validator: (v) {
                      if (v == null || v.isEmpty) return null;
                      if (v.startsWith('https')) return null;
                      if (v.startsWith('http')) return 'Plain HTTP is insecure';
                      return 'Unsupported scheme';
                    },
                    onChanged: (v) =>
                        setState(() => _hasSubscriptionUrl = v.isNotEmpty),
                    onSaved: (v) => setState(() {
                      _groupDto = _groupDto.copyWith(
                        subscriptionURL: v == null || v.isEmpty
                            ? null
                            : Uri.parse(v),
                      );
                    }),
                  ),

                  FormField<bool>(
                    // FIXME
                    initialValue: isNew
                        ? _subscriptionAutoUpdate
                        : _groupDto.selected,
                    onSaved: (v) => setState(() {
                      _groupDto = _groupDto.copyWith(selected: v ?? false);
                    }),

                    builder: (FormFieldState<bool> state) => Tooltip(
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
                              : (v) {
                                  setState(() => _subscriptionAutoUpdate = v);
                                  state.didChange(v);
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
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Required' : null,
                      onSaved: (v) => setState(() {
                        final parsed = int.tryParse(v ?? '');
                        _groupDto = _groupDto.copyWith(
                          autoUpdateInterval: parsed ?? 360,
                        );
                      }),
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
