-- =====================================================
-- Base de Datos: Tienda de Maquillaje
-- Archivo: DQL (Data Query Language)
-- =====================================================

USE tienda_maquillaje;

-- =====================================================
-- PROCEDIMIENTO 1: Listar cosméticos por tipo específico
-- Descripción: Lista todos los productos de cosméticos de un tipo específico
-- Parámetros: p_tipo (VARCHAR) - tipo de cosmético (ej: 'labial', 'base', 'sombra')
-- Ejemplo: CALL listar_cosmeticos_por_tipo('labial');
-- =====================================================

DELIMITER //

CREATE PROCEDURE listar_cosmeticos_por_tipo(IN p_tipo VARCHAR(50))
BEGIN
    SELECT 
        p.id_producto,
        p.nombre AS nombre_producto,
        p.descripcion,
        p.precio,
        p.stock,
        c.tipo,
        c.tono_color,
        c.fecha_expiracion
    FROM productos p
    JOIN cosmeticos c ON p.id_producto = c.id_producto
    JOIN categorias cat ON p.id_categoria = cat.id_categoria
    WHERE cat.nombre = 'cosméticos' 
      AND c.tipo = p_tipo
    ORDER BY p.nombre;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 2: Productos por categoría con stock bajo
-- Descripción: Obtiene productos en una categoría con stock inferior a un valor dado
-- Parámetros: p_categoria (VARCHAR), p_stock_minimo (INT)
-- Ejemplo: CALL productos_stock_bajo('cosméticos', 20);
-- =====================================================

DELIMITER //

CREATE PROCEDURE productos_stock_bajo(
    IN p_categoria VARCHAR(50), 
    IN p_stock_minimo INT
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        p.descripcion,
        p.precio,
        p.stock,
        cat.nombre AS categoria
    FROM productos p
    JOIN categorias cat ON p.id_categoria = cat.id_categoria
    WHERE cat.nombre = p_categoria 
      AND p.stock < p_stock_minimo
    ORDER BY p.stock ASC, p.nombre;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 3: Ventas por cliente en rango de fechas
-- Descripción: Muestra todas las ventas realizadas por un cliente en un rango de fechas
-- Parámetros: p_id_cliente (INT), p_fecha_inicio (DATE), p_fecha_fin (DATE)
-- Ejemplo: CALL ventas_por_cliente_fechas(1, '2026-01-01', '2026-04-30');
-- =====================================================

DELIMITER //

CREATE PROCEDURE ventas_por_cliente_fechas(
    IN p_id_cliente INT, 
    IN p_fecha_inicio DATE, 
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        v.id_venta,
        v.numero_venta,
        v.fecha_venta,
        cl.nombre_completo AS cliente,
        e.nombre_completo AS empleado,
        p.nombre AS producto,
        dv.cantidad,
        p.precio,
        (dv.cantidad * p.precio) AS subtotal
    FROM ventas v
    JOIN detalle_venta dv ON v.id_venta = dv.id_venta
    JOIN productos p ON dv.id_producto = p.id_producto
    JOIN clientes cl ON v.id_cliente = cl.id_cliente
    JOIN empleados e ON v.id_empleado = e.id_empleado
    WHERE v.id_cliente = p_id_cliente 
      AND v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY v.fecha_venta DESC, v.id_venta;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 4: Total ventas por empleado en un mes
-- Descripción: Calcula el total de ventas (en dinero) realizadas por un empleado en un mes dado
-- Parámetros: p_id_empleado (INT), p_mes (INT), p_anio (INT)
-- Ejemplo: CALL total_ventas_empleado_mes(1, 3, 2026);
-- =====================================================

DELIMITER //

CREATE PROCEDURE total_ventas_empleado_mes(
    IN p_id_empleado INT, 
    IN p_mes INT, 
    IN p_anio INT
)
BEGIN
    SELECT 
        e.id_empleado,
        e.nombre_completo,
        e.puesto,
        MONTH(v.fecha_venta) AS mes,
        YEAR(v.fecha_venta) AS anio,
        COUNT(DISTINCT v.id_venta) AS numero_ventas,
        SUM(dv.cantidad * p.precio) AS total_ventas_dinero,
        SUM(dv.cantidad) AS total_unidades_vendidas
    FROM ventas v
    JOIN detalle_venta dv ON v.id_venta = dv.id_venta
    JOIN productos p ON dv.id_producto = p.id_producto
    JOIN empleados e ON v.id_empleado = e.id_empleado
    WHERE v.id_empleado = p_id_empleado 
      AND MONTH(v.fecha_venta) = p_mes 
      AND YEAR(v.fecha_venta) = p_anio
    GROUP BY e.id_empleado, e.nombre_completo, e.puesto, MONTH(v.fecha_venta), YEAR(v.fecha_venta);
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 5: Productos más vendidos en un período
-- Descripción: Lista los productos más vendidos en un período determinado
-- Parámetros: p_fecha_inicio (DATE), p_fecha_fin (DATE)
-- Ejemplo: CALL productos_mas_vendidos('2026-01-01', '2026-06-30');
-- =====================================================

DELIMITER //

CREATE PROCEDURE productos_mas_vendidos(
    IN p_fecha_inicio DATE, 
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        cat.nombre AS categoria,
        SUM(dv.cantidad) AS total_unidades_vendidas,
        SUM(dv.cantidad * p.precio) AS total_ingresos,
        COUNT(DISTINCT dv.id_venta) AS numero_ventas
    FROM detalle_venta dv
    JOIN ventas v ON dv.id_venta = v.id_venta
    JOIN productos p ON dv.id_producto = p.id_producto
    JOIN categorias cat ON p.id_categoria = cat.id_categoria
    WHERE v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY p.id_producto, p.nombre, cat.nombre
    ORDER BY total_unidades_vendidas DESC;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 6: Stock disponible por producto
-- Descripción: Consulta el stock disponible de un producto por nombre o ID
-- Parámetros: p_identificador (VARCHAR) - puede ser ID o nombre del producto
-- Ejemplo: CALL consultar_stock_producto('Labial');
-- Ejemplo: CALL consultar_stock_producto('1');
-- =====================================================

DELIMITER //

CREATE PROCEDURE consultar_stock_producto(IN p_identificador VARCHAR(100))
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        p.descripcion,
        p.precio,
        p.stock,
        cat.nombre AS categoria
    FROM productos p
    JOIN categorias cat ON p.id_categoria = cat.id_categoria
    WHERE p.id_producto = p_identificador 
       OR p.nombre LIKE CONCAT('%', p_identificador, '%')
    ORDER BY p.stock ASC, p.nombre;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 7: Órdenes de compra por proveedor último año
-- Descripción: Muestra las órdenes de compra realizadas a un proveedor en el último año
-- Parámetros: p_id_proveedor (INT)
-- Ejemplo: CALL ordenes_proveedor_ultimo_ano(1);
-- =====================================================

DELIMITER //

CREATE PROCEDURE ordenes_proveedor_ultimo_ano(IN p_id_proveedor INT)
BEGIN
    SELECT 
        oc.id_orden,
        oc.fecha_orden,
        prov.nombre_empresa,
        prov.nombre_contacto,
        p.nombre AS producto,
        do.cantidad_solicitada,
        do.cantidad_recibida
    FROM ordenes_compra oc
    JOIN detalle_orden do ON oc.id_orden = do.id_orden
    JOIN productos p ON do.id_producto = p.id_producto
    JOIN proveedores prov ON oc.id_proveedor = prov.id_proveedor
    WHERE oc.id_proveedor = p_id_proveedor 
      AND oc.fecha_orden >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ORDER BY oc.fecha_orden DESC, oc.id_orden;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 8: Empleados con más de un año
-- Descripción: Lista los empleados que han trabajado más de un año en la tienda
-- Parámetros: No requiere parámetros
-- Ejemplo: CALL empleados_mas_un_ano();
-- =====================================================

DELIMITER //

CREATE PROCEDURE empleados_mas_un_ano()
BEGIN
    SELECT 
        e.id_empleado,
        e.nombre_completo,
        e.puesto,
        e.area,
        e.fecha_contratacion,
        YEAR(CURDATE()) - YEAR(e.fecha_contratacion) AS anos_trabajados
    FROM empleados e
    WHERE e.fecha_contratacion <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ORDER BY e.fecha_contratacion ASC;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 9: Total productos vendidos en un día
-- Descripción: Obtiene la cantidad total de productos vendidos en un día específico
-- Parámetros: p_fecha (DATE)
-- Ejemplo: CALL total_vendidos_dia('2026-03-12');
-- =====================================================

DELIMITER //

CREATE PROCEDURE total_vendidos_dia(IN p_fecha DATE)
BEGIN
    SELECT 
        p_fecha AS fecha,
        COUNT(DISTINCT v.id_venta) AS numero_ventas,
        SUM(dv.cantidad) AS total_unidades_vendidas,
        SUM(dv.cantidad * p.precio) AS total_ingresos_dia
    FROM detalle_venta dv
    JOIN ventas v ON dv.id_venta = v.id_venta
    JOIN productos p ON dv.id_producto = p.id_producto
    WHERE v.fecha_venta = p_fecha;
END //

DELIMITER ;

-- =====================================================
-- PROCEDIMIENTO 10: Ventas de producto específico
-- Descripción: Consulta las ventas de un producto específico y cuántas unidades se vendieron
-- Parámetros: p_identificador (VARCHAR) - puede ser ID o nombre del producto
-- Ejemplo: CALL ventas_producto_especifico('Labial');
-- Ejemplo: CALL ventas_producto_especifico('1');
-- =====================================================

DELIMITER //

CREATE PROCEDURE ventas_producto_especifico(IN p_identificador VARCHAR(100))
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        p.descripcion,
        p.precio,
        cat.nombre AS categoria,
        COUNT(DISTINCT dv.id_venta) AS numero_ventas,
        SUM(dv.cantidad) AS total_unidades_vendidas,
        SUM(dv.cantidad * p.precio) AS total_ingresos
    FROM detalle_venta dv
    JOIN ventas v ON dv.id_venta = v.id_venta
    JOIN productos p ON dv.id_producto = p.id_producto
    JOIN categorias cat ON p.id_categoria = cat.id_categoria
    WHERE p.id_producto = p_identificador 
       OR p.nombre LIKE CONCAT('%', p_identificador, '%')
    GROUP BY p.id_producto, p.nombre, p.descripcion, p.precio, cat.nombre;
END //

DELIMITER ;

-- =====================================================
-- EJEMPLOS DE USO DE LOS PROCEDIMIENTOS
-- =====================================================

-- 1. Listar cosméticos de tipo 'labial'
-- CALL listar_cosmeticos_por_tipo('labial');

-- 2. Productos de cosméticos con stock menor a 20
-- CALL productos_stock_bajo('cosméticos', 20);

-- 3. Ventas del cliente 1 entre enero y abril de 2024
-- CALL ventas_por_cliente_fechas(1, '2024-01-01', '2024-04-30');

-- 4. Total ventas del empleado 1 en marzo de 2024
-- CALL total_ventas_empleado_mes(1, 3, 2024);

-- 5. Productos más vendidos en el primer semestre de 2024
-- CALL productos_mas_vendidos('2024-01-01', '2024-06-30');

-- 6. Consultar stock de productos con nombre 'Labial'
-- CALL consultar_stock_producto('Labial');

-- 7. Órdenes de compra al proveedor 1 en el último año
-- CALL ordenes_proveedor_ultimo_ano(1);

-- 8. Empleados con más de un año de antigüedad
-- CALL empleados_mas_un_ano();

-- 9. Total vendidos el 12 de marzo de 2024
-- CALL total_vendidos_dia('2024-03-12');

-- 10. Ventas del producto 'Labial Matte Rojo'
-- CALL ventas_producto_especifico('Labial Matte Rojo');

-- =====================================================
-- VERIFICACIÓN DE PROCEDIMIENTOS CREADOS
-- =====================================================

-- Listar todos los procedimientos almacenados en la base de datos
SELECT 
    ROUTINE_NAME AS nombre_procedimiento,
    ROUTINE_TYPE AS tipo,
    DTD_IDENTIFIER AS parametros
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = 'tienda_maquillaje'
  AND ROUTINE_TYPE = 'PROCEDURE'
ORDER BY ROUTINE_NAME;

-- =====================================================
-- FIN DEL SCRIPT DQL
-- =====================================================