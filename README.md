Lenguaje M: Explorando el Editor Avanzado de Power Query
Dataset seleccionado
Para esta práctica se utilizó el dataset "Ventas_export_legacy.xlsx".

Justificación
El dataset fue seleccionado porque contiene distintos tipos de datos (texto, fecha y valores numéricos), además de presentar nombres técnicos de columnas, registros duplicados y valores nulos. Estas características permiten realizar transformaciones significativas en Power Query y observar cómo dichas transformaciones se traducen al lenguaje M.

Transformaciones realizadas desde la interfaz gráfica
Cambio de tipo de dato de la columna F_VTA a Fecha.
Filtrado de registros donde TOT_VTA > 1000.
Renombrado de la columna COD_CLI a cliente_id.
Código M final
let
    Origen = Excel.Workbook(File.Contents("C:\Users\manu_\Downloads\Ventas_export_legacy.xlsx"), null, true),
    VENTAS_EXPORT_Sheet = Origen{[Item="VENTAS_EXPORT",Kind="Sheet"]}[Data],
    #"Encabezados promovidos" = Table.PromoteHeaders(VENTAS_EXPORT_Sheet, [PromoteAllScalars=true]),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos",{{"COD_OP", type text}, {"COD_CLI", type text}}),
    #"Tipo cambiado1" = Table.TransformColumnTypes(#"Tipo cambiado",{{"F_VTA", type date}}),
    #"Filas filtradas" = Table.SelectRows(#"Tipo cambiado1", each [TOT_VTA] > 1000),

    // Renombramos la columna de cliente para mejorar la legibilidad del dataset
    #"MiTransformacionManual" = Table.RenameColumns(#"Filas filtradas",{{"COD_CLI", "cliente_id"}})

in
    #"MiTransformacionManual"
