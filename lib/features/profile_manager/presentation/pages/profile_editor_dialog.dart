import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart'
    show TextInputFormatter, FilteringTextInputFormatter;
import 'package:yet_another_xray_gui/core/util/util.dart'
    show CapitalizedString;
import 'package:yet_another_xray_gui/features/profile_manager/domain/dto/xray_profile_dto.dart';

class ProfileEditorDialog extends StatefulWidget {
  const ProfileEditorDialog({super.key, this.profileDto});

  final XRAYProfileDTO? profileDto;

  @override
  State<ProfileEditorDialog> createState() => _ProfileEditorDialogState();
}

class _ProfileEditorDialogState extends State<ProfileEditorDialog> {
  final _formKey = GlobalKey<FormState>();

  void _saveForm(BuildContext context, XRAYProfileDTO profileDto) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print(profileDto.toString());

      Navigator.pop(context, profileDto);
    }
  }

  @override
  Widget build(BuildContext context) {
    XRAYProfileDTO profileDto =
        widget.profileDto ??
        XRAYProfileDTO(tag: 'invalid', protocol: XRAYProtocols.vless);
    bool isNew = widget.profileDto == null;

    return AlertDialog(
      title: Center(
        child: Text(isNew ? 'Create a profile' : 'Edit the profile'),
      ),
      actions: [
        Row(
          children: [
            if (isNew)
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.content_paste_go),
                label: const Text('Use the link instead'),
              ),
            if (isNew) const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                _saveForm(context, profileDto);
              },
              child: Text(isNew ? 'Create' : 'Save'),
            ),
          ],
        ),
      ],
      content: SizedBox(
        width: MediaQuery.widthOf(context) / 1.5,
        height: MediaQuery.heightOf(context) / 1.5,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: const Row(
              spacing: 16.0,
              children: [
                Expanded(child: GeneralSection()),
                VerticalDivider(),
                Expanded(child: ProtocolSection()),
                VerticalDivider(),
                Expanded(child: StreamSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 4,
      children: [
        Text(
          'General',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: .bold),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Name', helperText: ''),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),

        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Address',
            helperText: '',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),

        TextFormField(
          decoration: const InputDecoration(labelText: 'Port', helperText: ''),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),

        TextFormField(
          decoration: const InputDecoration(labelText: 'Tag', helperText: ''),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),

        DropdownMenuFormField(
          decorationBuilder: (context, controller) =>
              const InputDecoration(labelText: 'Protocol', helperText: ''),
          requestFocusOnTap: false,
          inputDecorationTheme: const InputDecorationTheme(),
          expandedInsets: const EdgeInsets.all(0),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => (value == null) ? 'Required' : null,
          dropdownMenuEntries: List<DropdownMenuEntry>.generate(
            XRAYProtocols.values.length,
            (int index) => DropdownMenuEntry(
              value: XRAYProtocols.values[index],
              label: XRAYProtocols.values[index].name.toCapitalized(),
            ),
          ),
        ),
      ],
    );
  }
}

class ProtocolSection extends StatelessWidget {
  const ProtocolSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Protocol settings',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: .bold),
        ),
      ],
    );
  }
}

class StreamSection extends StatelessWidget {
  const StreamSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Stream settings',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: .bold),
        ),
      ],
    );
  }
}
