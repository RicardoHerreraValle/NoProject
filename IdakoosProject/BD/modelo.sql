DROP TABLE "Producto";
DROP TABLE "Color";
DROP TABLE "Talla";
DROP TABLE "AreaImpresion";
DROP TABLE "Producto_Color";
DROP TABLE "Producto_AreaImpresion";
DROP TABLE "Objeto";

CREATE TABLE "Producto" (
"Codigo" VARCHAR(255) NOT NULL,
"Nombre" VARCHAR(255) NULL,
"Descripción" VARCHAR(255) NULL,
"Imagen" VARCHAR(255) NULL,
"FechaModificacion" DATE NULL
);

CREATE TABLE "Color" (
"Codigo" VARCHAR(255) NULL,
"Nombre" VARCHAR(255) NULL,
"FechaModificacion" VARCHAR(255) NULL
);

CREATE TABLE "Talla" (
"Codigo" VARCHAR(255) NULL,
"Nombre" VARCHAR(255) NULL,
"FechaModificacion" VARCHAR(255) NULL
);

CREATE TABLE "AreaImpresion" (
"Codigo" VARCHAR(255) NULL,
"Nombre" VARCHAR(255) NULL,
"FechaModificacion" DATE NULL
);

CREATE TABLE "Producto_Color" (
"CodigoProducto" VARCHAR(255) NULL,
"CodigoColor" VARCHAR(255) NULL,
"Imagen" VARCHAR(255) NULL,
"CodigoTalla" VARCHAR(255) NULL
);

CREATE TABLE "Producto_AreaImpresion" (
"CodigoProducto" VARCHAR(255) NULL,
"CodigoAreaImpresion" VARCHAR(255) NULL,
"Alto" FLOAT(255) NULL,
"Ancho" FLOAT(255) NULL,
"Imagen" VARCHAR(255) NULL
);

CREATE TABLE "Objeto" (
"Codigo" INT NULL,
"TIpo" CHAR(255) NULL,
"PosicionX" FLOAT(255) NULL,
"PosicionY" FLOAT(255) NULL,
"AnguloRotacion" FLOAT(255) NULL,
"CodigoAreaImpresion" VARCHAR(255) NULL,
"CodigoProducto" VARCHAR(255) NULL
);


ALTER TABLE "Talla" ADD CONSTRAINT "fk_Talla_Producto_Color_1" FOREIGN KEY ("Codigo") REFERENCES "Producto_Color" ("CodigoTalla");
ALTER TABLE "Color" ADD CONSTRAINT "fk_Color_Producto_Color_1" FOREIGN KEY ("Codigo") REFERENCES "Producto_Color" ("CodigoColor");
ALTER TABLE "Producto" ADD CONSTRAINT "fk_Producto_Producto_Color_1" FOREIGN KEY ("Codigo") REFERENCES "Producto_Color" ("CodigoProducto");
ALTER TABLE "Producto" ADD CONSTRAINT "fk_Producto_Producto_AreaImpresion_1" FOREIGN KEY ("Codigo") REFERENCES "Producto_AreaImpresion" ("CodigoProducto");
ALTER TABLE "AreaImpresion" ADD CONSTRAINT "fk_AreaImpresion_Producto_AreaImpresion_1" FOREIGN KEY ("Codigo") REFERENCES "Producto_AreaImpresion" ("CodigoAreaImpresion");
ALTER TABLE "Producto_AreaImpresion" ADD CONSTRAINT "fk_Producto_AreaImpresion_Objeto_1" FOREIGN KEY ("CodigoProducto") REFERENCES "Objeto" ("CodigoProducto");
ALTER TABLE "Producto_AreaImpresion" ADD CONSTRAINT "fk_Producto_AreaImpresion_Objeto_2" FOREIGN KEY ("CodigoAreaImpresion") REFERENCES "Objeto" ("CodigoAreaImpresion");

