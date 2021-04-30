import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggl_linker/cubit/configs_cubit.dart';

import 'model/configs.dart';

class ConfigView extends StatefulWidget {
  @override
  _ConfigViewState createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  final _formKey = GlobalKey<FormState>();
  Configs _configs = Configs.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuration'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _save(context),
        child: Icon(Icons.save),
      ),
      body: BlocBuilder<ConfigsCubit, ConfigsState>(
        builder: (context, state) {
          _configs = state is ConfigsSet ? state.configs : Configs.empty();

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('Redmine'),
                    ),
                    TextFormField(
                      initialValue: _configs.redmineApiKey,
                      decoration: InputDecoration(
                        labelText: 'Redmine API Key',
                      ),
                      validator: _notEmpty,
                      onSaved: (value) => _configs.redmineApiKey = value!,
                    ),
                    TextFormField(
                      initialValue: _configs.redmineBaseUrl,
                      decoration: InputDecoration(
                        labelText: 'Redmine Base URL',
                      ),
                      validator: _notEmpty,
                      onSaved: (value) => _configs.redmineBaseUrl = value!,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text('Toggl'),
                    ),
                    TextFormField(
                      initialValue: _configs.togglUsername,
                      decoration: InputDecoration(
                        labelText: 'Toggl Username/Email',
                      ),
                      validator: _notEmpty,
                      onSaved: (value) => _configs.togglUsername = value!,
                    ),
                    TextFormField(
                      initialValue: _configs.togglApiKey,
                      decoration: InputDecoration(
                        labelText: 'Toggl API Key',
                      ),
                      validator: _notEmpty,
                      onSaved: (value) => _configs.togglApiKey = value!,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<ConfigsCubit>().configure(_configs);
      Navigator.pop(context);
    }
  }

  String? _notEmpty(String? value) =>
      value != null && value.trim().isNotEmpty ? null : 'Invalid value';
}
