-- =====================================================
-- Base de Datos: Tienda de Maquillaje
-- Archivo: DML (Data Manipulation Language)
-- =====================================================

USE tienda_maquillaje;

-- =====================================================
-- INSERTAR CATEGORÍAS (TABLA PADRE)
-- =====================================================
-- Primero inserto las categorías porque los productos necesitan referencia a ellas
INSERT INTO categorias (nombre, descripcion) VALUES
('cosméticos', 'Productos de maquillaje facial, labial, ojos, etc.'),
('cuidado de la piel', 'Productos para el cuidado y limpieza de la piel'),
('perfumes', 'Fragancias y perfumes diversos'),
('accesorios', 'Herramientas y accesorios para aplicación de maquillaje');

-- =====================================================
-- INSERTAR CLIENTES (TABLA PADRE)
-- =====================================================
-- Inserto 15 clientes con datos variados para tener buenas pruebas
INSERT INTO clientes (nombre_completo, correo_electronico, direccion, telefono) VALUES
('María García López', 'maria.garcia@email.com', 'Calle Principal 123, Ciudad', '555-0101'),
('Ana Rodríguez Martínez', 'ana.rodriguez@email.com', 'Avenida Central 456, Ciudad', '555-0102'),
('Laura Fernández Sánchez', 'laura.fernandez@email.com', 'Calle Secundaria 789, Ciudad', '555-0103'),
('Carmen González Pérez', 'carmen.gonzalez@email.com', 'Boulevard 321, Ciudad', '555-0104'),
('Sofía Díaz Ruiz', 'sofia.diaz@email.com', 'Plaza Mayor 654, Ciudad', '555-0105'),
('Isabel Herrera Torres', 'isabel.herrera@email.com', 'Calle Nueva 987, Ciudad', '555-0106'),
('Patricia Ramos Jiménez', 'patricia.ramos@email.com', 'Avenida Libertad 159, Ciudad', '555-0107'),
('Teresa Medina Flores', 'teresa.medina@email.com', 'Calle Real 357, Ciudad', '555-0108'),
('Elena Castro Cruz', 'elena.castro@email.com', 'Paseo Reforma 753, Ciudad', '555-0109'),
('Rosa Ortiz Morales', 'rosa.ortiz@email.com', 'Calle Héroes 246, Ciudad', '555-0110'),
('Lucía Guerrero Navarro', 'lucia.guerrero@email.com', 'Avenida Independencia 864, Ciudad', '555-0111'),
('Pilar Vargas Ríos', 'pilar.vargas@email.com', 'Boulevard Juárez 135, Ciudad', '555-0112'),
('Mónica Soto Méndez', 'monica.soto@email.com', 'Calle Federal 468, Ciudad', '555-0113'),
('Diana Lara Vega', 'diana.lara@email.com', 'Plaza Central 791, Ciudad', '555-0114'),
('Victoria Reyes Castro', 'victoria.reyes@email.com', 'Avenida Revolución 357, Ciudad', '555-0115');

-- =====================================================
-- INSERTAR EMPLEADOS (TABLA PADRE)
-- =====================================================

INSERT INTO empleados (nombre_completo, puesto, fecha_contratacion, area) VALUES
('Carlos Mendoza Ruiz', 'Vendedor', '2023-03-15', 'venta'),
('Patricia Silva Flores', 'Vendedora', '2024-01-10', 'venta'),
('Roberto Hernández López', 'Encargado de Bodega', '2022-06-20', 'bodega'),
('Alicia Torres Sánchez', 'Gerente', '2021-02-01', 'administración'),
('Miguel Ángel Ramírez', 'Vendedor', '2024-07-25', 'venta'),
('Daniela Vargas Cruz', 'Vendedora', '2023-11-12', 'venta'),
('Jorge Luis Moreno', 'Auxiliar de Bodega', '2024-04-18', 'bodega'),
('Sandra Patricia Ramos', 'Contadora', '2022-09-30', 'administración'),
('Fernando Gutiérrez Díaz', 'Vendedor', '2023-08-05', 'venta'),
('Claudia Isabel Rojas', 'Vendedora', '2024-02-14', 'venta'),
('Ricardo Benítez Mora', 'Encargado de Bodega', '2021-12-15', 'bodega'),
('María Elena Campos', 'Gerente de Ventas', '2020-05-20', 'administración'),
('José Alfredo Fuentes', 'Vendedor', '2024-10-01', 'venta'),
('Laura Beatriz Paredes', 'Vendedora', '2023-06-28', 'venta'),
('Andrés Miguel Serrano', 'Auxiliar de Bodega', '2024-09-10', 'bodega');

-- =====================================================
-- INSERTAR PROVEEDORES (TABLA PADRE)
-- =====================================================

INSERT INTO proveedores (nombre_empresa, nombre_contacto, telefono, direccion) VALUES
('Cosméticos Deluxe S.A.', 'Roberto Martínez', '555-1001', 'Zona Industrial 1, Parque Industrial'),
('Belleza Natural Ltd.', 'Carmen Vega', '555-1002', 'Calle Comercio 45, Centro Empresarial'),
('Perfumes Elite Cía.', 'Diego Torres', '555-1003', 'Avenida Industrial 123, Zona Norte'),
('Accesorios Pro Inc.', 'Laura Sánchez', '555-1004', 'Boulevard Empresarial 789, Parque Sur'),
('Skin Care Solutions', 'Pedro Ramírez', '555-1005', 'Calle Tecnológica 456, Parque Tecnológico'),
('Make Up Essentials', 'Ana María González', '555-1006', 'Plaza Comercial 321, Centro'),
('Fragancias del Mundo', 'Luis Fernando Herrera', '555-1007', 'Avenida Exportación 654, Zona Franca'),
('Beauty Tools Corp.', 'María Isabel Cruz', '555-1008', 'Calle Manufactura 987, Industrial'),
('Derma Care Products', 'Carlos Alberto Ruiz', '555-1009', 'Boulevard Salud 159, Médica'),
('Color Palette Co.', 'Sofía Carolina Díaz', '555-1010', 'Avenida Arte 468, Zona Cultural'),
('Glamour Supplies', 'Jorge Eduardo Navarro', '555-1011', 'Calle Moda 791, Fashion District'),
('Pure Ingredients Ltd.', 'Patricia Alejandra Mora', '555-1012', 'Plaza Natural 357, Eco Park'),
('Scent Master Inc.', 'Ricardo David Vega', '555-1013', 'Avenida Aroma 246, Perfume Valley'),
('Tool Masters Cía.', 'Andrés Felipe Castro', '555-1014', 'Calle Herramientas 864, Tool City'),
('Beauty World Distributors', 'María Guadalupe Reyes', '555-1015', 'Boulevard Belleza 135, Beauty Plaza');

-- =====================================================
-- INSERTAR PRODUCTOS (HIJO DE CATEGORÍAS)
-- =====================================================

-- Productos de cosméticos (id_categoria = 1)
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Labial Matte Rojo', 'Labial acabado mate color rojo intenso', 15.99, 25, 1),
('Base de Maquillaje Beige', 'Base líquida tono beige para todo tipo de piel', 24.99, 18, 1),
('Sombra de Ojos Dorada', 'Paleta de sombras tonos dorados', 19.99, 30, 1),
('Rimel Negro Volumen', 'Rimel negro efecto volumen extra', 12.99, 22, 1),
('Labial Gloss Rosa', 'Labial brillo tono rosa natural', 14.99, 20, 1),
('Corrector Líquido Beige', 'Corrector líquido tono beige claro', 16.99, 15, 1),
('Polvo Compacto Translúcido', 'Polvo compacto acabado translúcido', 18.99, 28, 1),
('Delineador Líquido Negro', 'Delineador líquido punta fina negro', 11.99, 35, 1),
('Iluminador Dorado', 'Iluminador en polvo tono dorado', 21.99, 12, 1),
('Labial Matte Nude', 'Labial acabado mate tono nude', 15.99, 27, 1),
('Sombra de Ojos Negra', 'Sombra de ojos color negro mate', 8.99, 40, 1),
('Base de Maquillaje Clara', 'Base líquida tono muy claro', 24.99, 16, 1),
('Rimel Marrón Natural', 'Rimel color marrón natural', 12.99, 24, 1),
('Corrector en Barra', 'Corrector en barra tono medio', 14.99, 19, 1),
('Blush Rosa Pálido', 'Blush en polvo tono rosa pálido', 17.99, 21, 1);

-- Productos de cuidado de la piel (id_categoria = 2)
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Limpiador Facial Suave', 'Limpiador facial para piel sensible', 18.99, 32, 2),
('Hidratante Día SPF 30', 'Crema hidratante con protección solar', 28.99, 25, 2),
('Tónico Facial Refrescante', 'Tónico facial refrescante y revitalizante', 15.99, 28, 2),
('Mascarilla Facial Arcilla', 'Mascarilla de arcilla para piel grasa', 22.99, 18, 2),
('Serum Vitamina C', 'Serum concentrado con vitamina C', 35.99, 15, 2),
('Exfoliante Facial Suave', 'Exfoliante facial con microperlas', 19.99, 22, 2),
('Crema Noche Reparadora', 'Crema nocturna reparadora', 32.99, 20, 2),
('Contorno de Ojos', 'Crema para contorno de ojos', 29.99, 17, 2),
('Ácido Hialurónico', 'Sérum de ácido hialurónico puro', 24.99, 23, 2),
('Protector Solar SPF 50', 'Protector solar alta protección', 26.99, 30, 2),
('Limpiador Espuma', 'Limpiador en espuma para piel mixta', 16.99, 26, 2),
('Mascarilla Hidratante', 'Mascarilla hidratante intensiva', 21.99, 19, 2),
('Tónico Exfoliante', 'Tónico con ácidos exfoliantes', 17.99, 24, 2),
('Crema Anti-Edad', 'Crema anti-edad con retinol', 45.99, 12, 2),
('Agua Micelar', 'Agua micelar desmaquillante', 14.99, 35, 2);

-- Productos de perfumes (id_categoria = 3)
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Perfume Floral Rose', 'Perfume aroma floral rosas', 59.99, 15, 3),
('Perfume Cítrico Fresh', 'Perfume aroma cítrico fresco', 54.99, 18, 3),
('Perfume Madera Oriental', 'Perfume aroma madera oriental', 69.99, 12, 3),
('Perfume Frutal Berry', 'Perfume aroma frutas del bosque', 49.99, 20, 3),
('Perfume Vanilla Sweet', 'Perfume aroma vainilla dulce', 56.99, 16, 3),
('Perfume Ocean Breeze', 'Perfume aroma marino fresco', 58.99, 14, 3),
('Perfume Lavender Calm', 'Perfume aroma lavanda relajante', 52.99, 19, 3),
('Perfume Amber Warm', 'Perfume aroma ámbar cálido', 64.99, 13, 3),
('Perfume Jasmine Night', 'Perfume aroma jazmín nocturno', 62.99, 17, 3),
('Perfume Citrus Zest', 'Perfume aroma cítrico intenso', 51.99, 21, 3),
('Perfume Sandalwood', 'Perfume aroma sándalo elegante', 67.99, 11, 3),
('Perfume Lily Spring', 'Perfume aroma lirio primaveral', 55.99, 18, 3),
('Perfume Musk Sensual', 'Perfume aroma almizcle sensual', 63.99, 15, 3),
('Perfume Peony Bloom', 'Perfume aroma peonía floreciente', 57.99, 16, 3),
('Perfume Bergamot Fresh', 'Perfume aroma bergamota fresca', 53.99, 20, 3);

-- Productos de accesorios (id_categoria = 4)
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Set de Pinceles', 'Set de 12 pinceles profesionales', 34.99, 22, 4),
('Esponja de Maquillaje', 'Esponja blending para maquillaje', 8.99, 45, 4),
('Espejo de Mano', 'Espejo de mano con iluminación LED', 14.99, 28, 4),
('Pincel Kabuki', 'Pincel kabuki para polvos compactos', 12.99, 32, 4),
('Limpiador de Pinceles', 'Limpiador líquido para pinceles', 9.99, 38, 4),
('Porta Cosméticos', 'Organizador porta cosméticos', 19.99, 25, 4),
('Cepillo para Cejas', 'Cepillo para peinado de cejas', 6.99, 50, 4),
('Pincel para Labios', 'Pincel fino para labios', 7.99, 42, 4),
('Esponja Beauty Blender', 'Esponja beauty blender original', 11.99, 35, 4),
('Pinza Depilatoria', 'Pinza para depilación de cejas', 8.99, 40, 4),
('Maletín Maquillaje', 'Maletín profesional para maquillaje', 49.99, 15, 4),
('Espejo de Mesa', 'Espejo de mesa con magnificación', 24.99, 20, 4),
('Pincel Contorno', 'Pincel angular para contorno', 13.99, 30, 4),
('Soporte para Pinceles', 'Soporte organizador de pinceles', 16.99, 26, 4),
('Bolsa de Viaje', 'Bolsa de viaje para cosméticos', 21.99, 23, 4);

-- =====================================================
-- INSERTAR PRODUCTOS ESPECÍFICOS POR CATEGORÍA
-- =====================================================

-- Cosméticos (id_producto: 1-15)
INSERT INTO cosmeticos (id_producto, tipo, tono_color, fecha_expiracion) VALUES
(1, 'labial', 'rojo intenso', '2025-09-08'),
(2, 'base', 'beige medio', '2025-03-15'),
(3, 'sombra', 'dorado', '2026-01-20'),
(4, 'rimel', 'negro', '2025-06-10'),
(5, 'labial', 'rosa natural', '2025-12-05'),
(6, 'corrector', 'beige claro', '2025-08-18'),
(7, 'polvo', 'translúcido', '2026-04-25'),
(8, 'delineador', 'negro', '2025-10-12'),
(9, 'iluminador', 'dorado', '2025-11-30'),
(10, 'labial', 'nude', '2025-07-22'),
(11, 'sombra', 'negro', '2026-02-14'),
(12, 'base', 'muy claro', '2025-04-08'),
(13, 'rimel', 'marrón', '2025-09-28'),
(14, 'corrector', 'medio', '2025-05-16'),
(15, 'blush', 'rosa pálido', '2025-12-20');

-- Cuidado de la piel (id_producto: 16-30)
INSERT INTO cuidado_piel (id_producto, tipo_piel, componentes_principales, fecha_expiracion) VALUES
(16, 'mixta', 'Aloe vera, camomila', '2025-03-10'),
(17, 'todas', 'Ácido hialurónico, SPF 30', '2025-06-15'),
(18, 'grasa', 'Ácido salicílico, menta', '2025-04-20'),
(19, 'grasa', 'Arcilla blanca, carbón', '2025-02-28'),
(20, 'todas', 'Vitamina C, ferulic', '2025-05-25'),
(21, 'todas', 'Microperlas jojoba', '2025-07-12'),
(22, 'seca', 'Retinol, ceramidas', '2025-08-30'),
(23, 'todas', 'Péptidos, cafeína', '2025-06-18'),
(24, 'todas', 'Ácido hialurónico 2%', '2025-09-05'),
(25, 'todas', 'FPS 50, UVA/UVB', '2025-10-22'),
(26, 'mixta', 'Espuma, glicerina', '2025-03-28'),
(27, 'seca', 'Hialurona, vitamina E', '2025-04-15'),
(28, 'mixta', 'AHA, BHA', '2025-05-08'),
(29, 'todas', 'Retinol 0.5%', '2025-07-20'),
(30, 'todas', 'Agua, micelas', '2025-12-31');

-- Perfumes (id_producto: 31-45)
INSERT INTO perfumes (id_producto, tipo_aroma, tamano) VALUES
(31, 'floral', '100ml'),
(32, 'cítrico', '100ml'),
(33, 'madera', '100ml'),
(34, 'frutal', '100ml'),
(35, 'dulce', '100ml'),
(36, 'marino', '100ml'),
(37, 'herbal', '100ml'),
(38, 'ambarado', '100ml'),
(39, 'floral', '100ml'),
(40, 'cítrico', '100ml'),
(41, 'madera', '100ml'),
(42, 'floral', '100ml'),
(43, 'ambarado', '100ml'),
(44, 'floral', '100ml'),
(45, 'cítrico', '100ml');

-- Accesorios (id_producto: 46-60)
INSERT INTO accesorios (id_producto, material, descripcion_especifica) VALUES
(46, 'sintético', 'Pinceles con fibras sintéticas de alta calidad'),
(47, 'espuma', 'Esponja de látex no porosa'),
(48, 'plástico/metal', 'Espejo con batería recargable'),
(49, 'sintético', 'Pelo denso para aplicación uniforme'),
(50, 'líquido', 'Solución limpiadora antibacteriana'),
(51, 'acrílico', 'Organizador transparente con múltiples compartimentos'),
(52, 'metal', 'Cepillo metálico de precisión'),
(53, 'sintético', 'Pelo sintético suave'),
(54, 'espuma', 'Material latex-free'),
(55, 'metal', 'Acero inoxidable con punta precisión'),
(56, 'nailon', 'Material resistente y lavable'),
(57, 'cristal/metal', 'Marco metálico con espejo amplio'),
(58, 'sintético', 'Pelo angular definido'),
(59, 'acrílico', 'Base estable con ranuras'),
(60, 'nailon', 'Material impermeable');

-- =====================================================
-- INSERTAR VENTAS (HIJO DE CLIENTES Y EMPLEADOS)
-- =====================================================

INSERT INTO ventas (numero_venta, fecha_venta, id_cliente, id_empleado) VALUES
('V001', '2024-01-15', 1, 1),
('V002', '2024-01-18', 2, 2),
('V003', '2024-01-22', 3, 1),
('V004', '2024-02-05', 4, 5),
('V005', '2024-02-10', 5, 2),
('V006', '2024-02-15', 6, 1),
('V007', '2024-02-20', 7, 6),
('V008', '2024-03-01', 8, 5),
('V009', '2024-03-08', 9, 2),
('V010', '2024-03-12', 10, 1),
('V011', '2024-03-18', 11, 6),
('V012', '2024-03-25', 12, 5),
('V013', '2024-04-02', 13, 2),
('V014', '2024-04-10', 14, 1),
('V015', '2024-04-18', 15, 6),
('V016', '2024-04-25', 1, 5),
('V017', '2024-05-02', 2, 2),
('V018', '2024-05-08', 3, 1),
('V019', '2024-05-15', 4, 6),
('V020', '2024-05-22', 5, 5);

-- =====================================================
-- INSERTAR DETALLE DE VENTAS (HIJO DE VENTAS Y PRODUCTOS)
-- =====================================================

INSERT INTO detalle_venta (id_venta, id_producto, cantidad) VALUES
-- V001
(1, 1, 2), (1, 4, 1), (1, 46, 1),
-- V002
(2, 2, 1), (2, 7, 1), (2, 47, 2),
-- V003
(3, 3, 1), (3, 8, 1), (3, 31, 1),
-- V004
(4, 5, 2), (4, 16, 1), (4, 48, 1),
-- V005
(5, 6, 1), (5, 17, 1), (5, 49, 1),
-- V006
(6, 9, 1), (6, 18, 1), (6, 32, 1),
-- V007
(7, 10, 2), (7, 19, 1), (7, 50, 1),
-- V008
(8, 11, 1), (8, 20, 1), (8, 51, 1),
-- V009
(9, 12, 1), (9, 21, 1), (9, 33, 1),
-- V010
(10, 13, 1), (10, 22, 1), (10, 52, 1),
-- V011
(11, 14, 1), (11, 23, 1), (11, 34, 1),
-- V012
(12, 15, 2), (12, 24, 1), (12, 53, 1),
-- V013
(13, 1, 1), (13, 25, 1), (13, 35, 1),
-- V014
(14, 2, 1), (14, 26, 1), (14, 54, 1),
-- V015
(15, 3, 1), (15, 27, 1), (15, 36, 1),
-- V016
(16, 4, 2), (16, 28, 1), (16, 55, 1),
-- V017
(17, 5, 1), (17, 29, 1), (17, 37, 1),
-- V018
(18, 6, 1), (18, 30, 1), (18, 56, 1),
-- V019
(19, 7, 1), (19, 16, 1), (19, 38, 1),
-- V020
(20, 8, 1), (20, 17, 1), (20, 57, 1);

-- =====================================================
-- INSERTAR ÓRDENES DE COMPRA (HIJO DE PROVEEDORES)
-- =====================================================

INSERT INTO ordenes_compra (id_proveedor, fecha_orden) VALUES
(1, '2023-09-10'),
(2, '2023-10-15'),
(3, '2023-11-20'),
(4, '2023-12-05'),
(5, '2024-01-10'),
(6, '2024-02-15'),
(7, '2024-03-20'),
(8, '2024-04-25'),
(9, '2024-05-30'),
(10, '2024-06-10'),
(11, '2024-07-15'),
(12, '2024-08-20'),
(13, '2024-09-05'),
(14, '2024-09-07'),
(15, '2024-09-08');

-- =====================================================
-- INSERTAR DETALLE DE ÓRDENES (HIJO DE ÓRDENES Y PRODUCTOS)
-- =====================================================

INSERT INTO detalle_orden (id_orden, id_producto, cantidad_solicitada, cantidad_recibida) VALUES
-- Orden 1 (Proveedor 1 - Cosméticos)
(1, 1, 50, 50), (1, 2, 40, 40), (1, 3, 30, 30),
-- Orden 2 (Proveedor 2 - Belleza Natural)
(2, 16, 60, 60), (2, 17, 50, 50), (2, 18, 55, 55),
-- Orden 3 (Proveedor 3 - Perfumes Elite)
(3, 31, 25, 25), (3, 32, 25, 25), (3, 33, 20, 20),
-- Orden 4 (Proveedor 4 - Accesorios Pro)
(4, 46, 40, 40), (4, 47, 50, 50), (4, 48, 30, 30),
-- Orden 5 (Proveedor 5 - Skin Care)
(5, 19, 35, 35), (5, 20, 30, 30), (5, 21, 40, 40),
-- Orden 6 (Proveedor 6 - Make Up Essentials)
(6, 4, 45, 45), (6, 5, 50, 50), (6, 6, 40, 40),
-- Orden 7 (Proveedor 7 - Fragancias)
(7, 34, 30, 30), (7, 35, 25, 25), (7, 36, 30, 30),
-- Orden 8 (Proveedor 8 - Beauty Tools)
(8, 49, 35, 35), (8, 50, 40, 40), (8, 51, 30, 30),
-- Orden 9 (Proveedor 9 - Derma Care)
(9, 22, 25, 25), (9, 23, 30, 30), (9, 24, 35, 35),
-- Orden 10 (Proveedor 10 - Color Palette)
(10, 7, 40, 40), (10, 8, 45, 45), (10, 9, 35, 35),
-- Orden 11 (Proveedor 11 - Glamour)
(11, 52, 30, 30), (11, 53, 35, 35), (11, 54, 40, 40),
-- Orden 12 (Proveedor 12 - Pure Ingredients)
(12, 25, 30, 30), (12, 26, 35, 35), (12, 27, 30, 30),
-- Orden 13 (Proveedor 13 - Scent Master)
(13, 37, 25, 25), (13, 38, 20, 20), (13, 39, 25, 25),
-- Orden 14 (Proveedor 14 - Tool Masters)
(14, 55, 30, 30), (14, 56, 35, 35), (14, 57, 25, 25),
-- Orden 15 (Proveedor 15 - Beauty World)
(15, 10, 40, 40), (15, 11, 45, 45), (15, 12, 35, 35);


