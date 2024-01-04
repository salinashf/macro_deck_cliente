import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_deck_client/util/constants.dart';
import 'package:macro_deck_client/util/custom_logger.dart';
import 'package:macro_deck_client/widget/screen/list_connect.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'device_register.dart';

class DeviceConnect extends StatefulWidget {
  const DeviceConnect({
    Key? key,
  }) : super(key: key);

  @override
  State<DeviceConnect> createState() => _DeviceConnectState();
}

class _DeviceConnectState extends State<DeviceConnect> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Box _boxLogin = Hive.box("login");
  final Box _boxAccounts = Hive.box("accounts");

  final TextEditingController _ctrlHost = TextEditingController();
  final TextEditingController _ctrlPort = TextEditingController();
  final FocusNode _focusFieldDeviceConnect = FocusNode();

  bool _obscureHost = false;
  bool _obscurePort = false;

  @override
  Widget build(BuildContext context) {
    if (_boxLogin.get("loginStatus") ?? false) {
      return DeviceList();
    }

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                "Macro Deck",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 5),
              Text(
                "Entry your device.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ctrlHost,
                obscureText: _obscureHost,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  MaskTextInputFormatter(
                      mask: '###.###.###.###', filter: {"#": RegExp(r'[0-9]')}),
                ],
                decoration: InputDecoration(
                  labelText: "Host/IP",
                  prefixIcon: const Icon(Icons.computer),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureHost = !_obscureHost;
                        });
                      },
                      icon: _obscureHost
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () =>
                    _focusFieldDeviceConnect.requestFocus(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Host/IP.";
                  } else if (!RegExp(validateIP).hasMatch(value)) {
                    return "Host/IP not is valid";
                  } else if (!_boxAccounts.containsKey(value)) {
                    return "Username is not registered.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ctrlPort,
                focusNode: _focusFieldDeviceConnect,
                obscureText: _obscurePort,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: "Port",
                  prefixIcon: const Icon(Icons.network_check_rounded),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePort = !_obscurePort;
                        });
                      },
                      icon: _obscurePort
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter port.";
                  } else if (!RegExp(validatePort).hasMatch(value)) {
                    return "Port not is valid";
                  } else if (value != _boxAccounts.get(_ctrlHost.text)) {
                    return "Wrong port.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _boxLogin.put("loginStatus", true);
                        _boxLogin.put("userName", _ctrlHost.text);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DeviceList();
                            },
                          ),
                        );
                      }
                    },
                    child: const Text("Connect to Device"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const DeviceList();
                              },
                            ),
                          );
                        },
                        child: const Text("Register Device"),
                      ),
                      const Text("/"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const DeviceRegister();
                              },
                            ),
                          );
                        },
                        child: const Text("List Device"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Device ID"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const DeviceRegister();
                              },
                            ),
                          );
                        },
                        child: const Text("DDE434"),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrlHost.dispose();
    _ctrlPort.dispose();
    _focusFieldDeviceConnect.dispose();
    super.dispose();
  }
}
