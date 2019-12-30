// TODO: Modelo de Entrada
import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_materiales.dart';

class Entrada {
  String id;
  MaterialC material;
  double kg;
  double pagado;
  DateTime fecha;

  double get precio => pagado / kg;

  Entrada({
    this.id,
    this.material,
    this.kg,
    this.pagado,
    this.fecha,
  });

  Entrada.fromMap(Map<String, dynamic> map, String id) {
    this.id = id;
    this.material = FirestoreMateriales.getMaterialByID(map['id_material']);
    this.kg = map['kg'];
    this.pagado = map['pagado'];
    this.fecha = map['fecha'];
  }

  Map<String, dynamic> toMap() {
    assert(this.id != null);

    Map<String, dynamic> map = Map<String, dynamic>();

    map['kg'] = this.kg;
    map['id_material'] = this.material.id;
    map['pagado'] = this.pagado;
    map['fecha'] = this.fecha;

    return map;
  }
}
