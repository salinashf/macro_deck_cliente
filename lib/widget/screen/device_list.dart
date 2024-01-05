import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_deck_client/model/saved_devices.dart';
import 'package:macro_deck_client/util/custom_logger.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeviceList createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  List<SavedDevices> deviceSaves = [];
  final Box _boxDevices = Hive.box("devices");

  @override
  void initState() {
    int index = 0;
    deviceSaves.clear();
    _boxDevices.toMap().forEach((key, value) {
      final List<String> values = value.split(':');
      deviceSaves.add(SavedDevices(
          id: index.toString(),
          idConnection: key,
          host: values[0],
          port: values[1]));
      index++;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Devices"),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    _boxDevices.clear();
                    deviceSaves.clear();
                    setState(() {
                      //refresh UI after deleting element from list
                    });
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return const DeviceConnect();
                    //     },
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete All'),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: deviceSaves.map((sDeviceOne) {
                return Card(
                  child: ListTile(
                    title: Text(sDeviceOne.idConnection),
                    subtitle: Text("${sDeviceOne.host} : ${sDeviceOne.port}"),
                    leading: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      onPressed: () {},
                      child: const Icon(Icons.devices),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: const Icon(Icons.delete),
                      onPressed: () {
                        logger.w(sDeviceOne.idConnection);
                        if (_boxDevices.containsKey(sDeviceOne.idConnection)) {
                          _boxDevices.delete(sDeviceOne.idConnection);
                          //delete action for this button
                          deviceSaves.removeWhere((element) {
                            return element.idConnection ==
                                sDeviceOne.idConnection;
                          });
                        }
                        //go through the loop and match content to delete from list
                        setState(() {
                          //refresh UI after deleting element from list
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
