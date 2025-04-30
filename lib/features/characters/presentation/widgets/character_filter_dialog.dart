// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character_filter.dart';

class CharacterFilterDialog extends StatefulWidget {
  const CharacterFilterDialog({super.key, this.filter});
  final CharacterFilter? filter;

  @override
  State<CharacterFilterDialog> createState() => _CharacterFilterDialogState();
}

class _CharacterFilterDialogState extends State<CharacterFilterDialog> {
  late final TextEditingController nameController;
  late final TextEditingController speciesController;
  late final TextEditingController typeController;
  late final TextEditingController statusController;
  late final TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.filter?.name);
    speciesController = TextEditingController(text: widget.filter?.species);
    typeController = TextEditingController(text: widget.filter?.type);
    statusController = TextEditingController(text: widget.filter?.status);
    genderController = TextEditingController(text: widget.filter?.gender);
  }

  @override
  void dispose() {
    nameController.dispose();
    speciesController.dispose();
    typeController.dispose();
    statusController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Dialog(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(title: Text('Filter'), centerTitle: true),
                  TextField(
                    controller: nameController,
                    onChanged: (_) => setState(() {}),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                  TextField(
                    controller: speciesController,
                    onChanged: (_) => setState(() {}),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Species',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                  TextField(
                    controller: typeController,
                    onChanged: (_) => setState(() {}),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: DropdownMenu(
                          controller: statusController,
                          onSelected: (_) => setState(() {}),
                          width: double.infinity,
                          hintText: 'Status',
                          dropdownMenuEntries: [
                            DropdownMenuEntry(label: 'Alive', value: 'alive'),
                            DropdownMenuEntry(label: 'Dead', value: 'dead'),
                            DropdownMenuEntry(
                              label: 'Unknown',
                              value: 'unknown',
                            ),
                          ],
                        ),
                      ),
                      if (statusController.text.isNotEmpty)
                        IconButton(
                          onPressed:
                              () => setState(() => statusController.text = ''),
                          icon: Icon(Icons.close),
                        ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: DropdownMenu(
                          controller: genderController,
                          onSelected: (_) => setState(() {}),
                          width: double.infinity,
                          hintText: 'Gender',
                          dropdownMenuEntries: [
                            DropdownMenuEntry(label: 'Male', value: 'male'),
                            DropdownMenuEntry(label: 'Female', value: 'female'),
                            DropdownMenuEntry(
                              label: 'Genderless',
                              value: 'genderless',
                            ),
                            DropdownMenuEntry(
                              label: 'Unknown',
                              value: 'unknown',
                            ),
                          ],
                        ),
                      ),
                      if (genderController.text.isNotEmpty)
                        IconButton(
                          onPressed:
                              () => setState(() => genderController.text = ''),
                          icon: Icon(Icons.close),
                        ),
                    ],
                  ),
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: FilledButton(
                            onPressed:
                                () => context.pop<CharacterFilter>(
                                  CharacterFilter(
                                    name: nameController.text,
                                    species: speciesController.text,
                                    gender: genderController.text,
                                    type: typeController.text,
                                    status: statusController.text,
                                  ),
                                ),
                            child: Text('Apply filter'),
                          ),
                        ),
                      ),
                      if (widget.filter != null)
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FilledButton(
                              onPressed:
                                  () => context.pop<CharacterFilter>(
                                    CharacterFilter(
                                      name: '',
                                      species: '',
                                      gender: '',
                                      type: '',
                                      status: '',
                                    ),
                                  ),
                              child: Text('Clear filter'),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
