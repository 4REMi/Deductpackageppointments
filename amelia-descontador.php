<?php
/**
 * Plugin Name: Amelia Descontador
 * Plugin URI: https://example.com/amelia-descontador
 * Description: Plugin para descontar clases manualmente en Amelia Booking.
 * Version: 1.0.0
 * Author: Tu Nombre
 * Author URI: https://example.com
 * Text Domain: amelia-descontador
 */

// Si este archivo es llamado directamente, abortar.
if (!defined('WPINC')) {
    die;
}

// Definir constantes
define('AMELIA_DESCONTADOR_VERSION', '1.0.0');
define('AMELIA_DESCONTADOR_PLUGIN_DIR', plugin_dir_path(__FILE__));
define('AMELIA_DESCONTADOR_PLUGIN_URL', plugin_dir_url(__FILE__));

/**
 * Función que se ejecuta durante la activación del plugin
 */
function activate_amelia_descontador() {
    // Verificar si Amelia está instalado y activado
    if (!class_exists('AmeliaBooking\Plugin')) {
        deactivate_plugins(plugin_basename(__FILE__));
        wp_die('Este plugin requiere que Amelia Booking esté instalado y activado.');
    }
}
register_activation_hook(__FILE__, 'activate_amelia_descontador');

/**
 * Cargar las dependencias del plugin
 */
function amelia_descontador_load_dependencies() {
    // Cargar modelos
    require_once AMELIA_DESCONTADOR_PLUGIN_DIR . 'includes/models/class-amelia-descontador-cliente.php';
    require_once AMELIA_DESCONTADOR_PLUGIN_DIR . 'includes/models/class-amelia-descontador-paquete.php';
    require_once AMELIA_DESCONTADOR_PLUGIN_DIR . 'includes/models/class-amelia-descontador-cita.php';
    
    // Cargar vistas
    require_once AMELIA_DESCONTADOR_PLUGIN_DIR . 'includes/views/class-amelia-descontador-admin-view.php';
    
    // Cargar controladores
    require_once AMELIA_DESCONTADOR_PLUGIN_DIR . 'includes/controllers/class-amelia-descontador-admin-controller.php';
}

/**
 * Inicializar el plugin
 */
function amelia_descontador_init() {
    // Cargar dependencias
    amelia_descontador_load_dependencies();
    
    // Inicializar controlador de administración
    $admin_controller = new Amelia_Descontador_Admin_Controller();
}

// Inicializar el plugin después de que todos los plugins estén cargados
add_action('plugins_loaded', 'amelia_descontador_init'); 