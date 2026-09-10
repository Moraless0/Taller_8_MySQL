-- =====================================================
-- Base de Datos: Tienda de Maquillaje
-- Archivo: DDL (Data Definition Language)
-- =====================================================

-- Eliminar base de datos si existe (para recrear desde cero)
-- Esto ayuda cuando estamos probando y queremos empezar de cero
DROP DATABASE IF EXISTS tienda_maquillaje;

-- Crear base de datos con utf8 para poder usar acentos y ñ
CREATE DATABASE tienda_maquillaje
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos que acabamos de crear
USE tienda_maquillaje;

-- =====================================================
-- TABLAS PRINCIPALES (PADRES)
-- =====================================================

-- Tabla: categorias
-- Aquí guardo las 4 categorías principales de productos
-- El CHECK constraint asegura que solo se puedan ingresar las categorías permitidas
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    CONSTRAINT chk_nombre_categoria CHECK (nombre IN ('cosméticos', 'cuidado de la piel', 'perfumes', 'accesorios'))
) ENGINE=InnoDB;

-- Tabla: clientes
-- Guardo la info de los clientes que compran en la tienda
-- El correo es UNIQUE para que no haya duplicados
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- Tabla: empleados
-- Almacena la información de los empleados de la tienda
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    area VARCHAR(50) NOT NULL,
    CONSTRAINT chk_area_empleado CHECK (area IN ('venta', 'bodega', 'administración'))
) ENGINE=InnoDB;

-- Tabla: proveedores
-- Almacena la información de los proveedores de productos
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    nombre_contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion TEXT NOT NULL
) ENGINE=InnoDB;

-- =====================================================
-- TABLA DE PRODUCTOS
-- =====================================================

-- Tabla: productos
-- Tabla general de productos con información común
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLAS ESPECÍFICAS POR CATEGORÍA DE PRODUCTO
-- =====================================================

-- Tabla: cosmeticos
-- Productos cosméticos con atributos específicos
CREATE TABLE cosmeticos (
    id_cosmetico INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL UNIQUE,
    tipo VARCHAR(50) NOT NULL COMMENT 'labial, base, sombra, etc.',
    tono_color VARCHAR(50),
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla: cuidado_piel
-- Productos de cuidado de la piel con atributos específicos
CREATE TABLE cuidado_piel (
    id_cuidado_piel INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL UNIQUE,
    tipo_piel VARCHAR(20) NOT NULL COMMENT 'seca, grasa, mixta, todas',
    componentes_principales TEXT,
    fecha_expiracion DATE,
    CONSTRAINT chk_tipo_piel CHECK (tipo_piel IN ('seca', 'grasa', 'mixta', 'todas')),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla: perfumes
-- Productos de perfumes con atributos específicos
CREATE TABLE perfumes (
    id_perfume INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL UNIQUE,
    tipo_aroma VARCHAR(50) NOT NULL,
    tamano VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla: accesorios
-- Productos de accesorios con atributos específicos
CREATE TABLE accesorios (
    id_accesorio INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL UNIQUE,
    material VARCHAR(50) NOT NULL,
    descripcion_especifica TEXT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLAS DE VENTAS
-- =====================================================

-- Tabla: ventas
-- Registro de las ventas realizadas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    numero_venta VARCHAR(20) NOT NULL UNIQUE,
    fecha_venta DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla: detalle_venta
-- Detalle de productos incluidos en cada venta
CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLAS DE ÓRDENES DE COMPRA
-- =====================================================

-- Tabla: ordenes_compra
-- Registro de órdenes de compra a proveedores
CREATE TABLE ordenes_compra (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha_orden DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla: detalle_orden
-- Detalle de productos en cada orden de compra
CREATE TABLE detalle_orden (
    id_detalle_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_solicitada INT NOT NULL CHECK (cantidad_solicitada > 0),
    cantidad_recibida INT NOT NULL DEFAULT 0 CHECK (cantidad_recibida >= 0),
    FOREIGN KEY (id_orden) REFERENCES ordenes_compra(id_orden) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- ÍNDICES PARA MEJORAR RENDIMIENTO
-- =====================================================

-- Índices para búsquedas frecuentes
CREATE INDEX idx_productos_categoria ON productos(id_categoria);
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX idx_ventas_cliente ON ventas(id_cliente);
CREATE INDEX idx_ordenes_compra_fecha ON ordenes_compra(fecha_orden);
