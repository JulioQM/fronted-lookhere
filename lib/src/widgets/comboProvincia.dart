import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';

class PopupMenuButtons {
  static PopupMenuButton comboProvincia(
      {String miprovincia, List<Provincia> prov, BuildContext context}) {
    /*  FutureBuilder(
                        future: state.getProvincias(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Provincia>> snapshot) {
                          List<Provincia> prov = snapshot.data ?? [];
                          print(prov);
                          print('...............pr.............'); */
    /* return PopupMenuButton<Provincia>(
      child: Container(
        child: Text('Selecione'),
      ),
      onSelected: (Provincia result) {
        
        setState(() {
          miprovincia = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Provincia>>[
        for (Provincia provincia in prov)
          PopupMenuItem<Provincia>(
            value: provincia,
            child: Text(provincia.provNombre),
          ),
      ],
    );
    /*   }, */
  }
}
 */
  }
}
