/*  
FutureBuilder(
                        future: state.getProvincias(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Provincia>> snapshot) {
                          List<Provincia> prov = snapshot.data ?? [];
                          print(prov);
                          print('...............pr.............');
                          return PopupMenuButton<Provincia>(
                            child: Container(
                              child: Text('Selecione'),
                            ),
                            onSelected: (Provincia result) {
                              setState(() {
                                miprovincia = result;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<Provincia>>[
                              for (Provincia provincia in prov)
                                PopupMenuItem<Provincia>(
                                  value: provincia,
                                  child: Text(provincia.provNombre),
                                ),
                            ],
                          );
                        },
                      ), */

import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';

class DropdownButtons {
  static DropdownButton combobox({Provincia p, List<Provincia> pro}) {
    return DropdownButton<String>(
      value: p.getProvNombre,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: [
        for (Provincia item in pro)
          DropdownMenuItem(
            value: item.provNombre,
            child: Text(item.provNombre),
          ),
      ],
    );
  }
}
