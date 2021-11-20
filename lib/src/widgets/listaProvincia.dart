import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:provider/provider.dart';

class FuterBuilders extends StatefulWidget {
  @override
  _FuterBuildersState createState() => _FuterBuildersState();
}

class _FuterBuildersState extends State<FuterBuilders> {
  Provincia miprovincia;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProvinciaProvider>(context);
    return FutureBuilder(
      future: state.getProvincias(),
      builder: (BuildContext context, AsyncSnapshot<List<Provincia>> snapshot) {
        List<Provincia> prov = snapshot.data ?? [];
        return Row(
          children: <Widget>[
            Icon(Icons.select_all, color: Colors.indigo),
            SizedBox(width: 20),
            Expanded(
              child: DropdownButton(
                hint: Text('Seleccione una Ciudad'),
                onChanged: (opt) {
                  setState(() {
                    miprovincia = opt;
                    print('.............');
                    print(miprovincia);
                  });
                },
                items: [
                  for (Provincia provincia in prov)
                    DropdownMenuItem(
                      value: provincia,
                      child: Text(provincia.provNombre),
                    ),
                ],
                isExpanded: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
