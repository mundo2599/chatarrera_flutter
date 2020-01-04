import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_materiales.dart';

class Entrada {
  String id;
  MaterialC material;
  double kg = 0;
  double pagado = 0;
  DateTime fecha;

  double get precio {
    if (kg == 0.0)
      return 0.0;
    else
      return double.parse((pagado / kg).toStringAsFixed(2));
  }

  Entrada({
    this.id,
    this.material,
    this.kg = 0,
    this.pagado = 0,
    this.fecha,
  });

  Entrada.fromMap(Map<String, dynamic> map, String id) {
    this.id = id;
    this.material = FirestoreMateriales.getMaterialByID(map['id_material']);
    this.kg = map['kg'];
    this.fecha = DateTime.parse(map['fecha']);
    this.pagado = map['pagado'];
  }

  Map<String, dynamic> toMap() {
    assert(this.material != null);

    Map<String, dynamic> map = Map<String, dynamic>();

    map['kg'] = this.kg;
    map['id_material'] = this.material.id;
    map['pagado'] = this.pagado;
    map['fecha'] = this.fecha.toString();

    return map;
  }

  Entrada operator +(Entrada other) {
    if (other.material != this.material)
      throw ('No se pueden sumar Entradas con materiales distintos');

    return Entrada(
      material: this.material,
      kg: this.kg + other.kg,
      pagado: this.pagado + other.pagado,
    );
  }
}
