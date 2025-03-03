<?php
/**
 * Controlador para la administración del plugin
 */
class Amelia_Descontador_Admin_Controller {
    
    /**
     * Modelo de cliente
     *
     * @var Amelia_Descontador_Cliente
     */
    private $cliente_model;
    
    /**
     * Modelo de paquete
     *
     * @var Amelia_Descontador_Paquete
     */
    private $paquete_model;
    
    /**
     * Modelo de cita
     *
     * @var Amelia_Descontador_Cita
     */
    private $cita_model;
    
    /**
     * Vista de administración
     *
     * @var Amelia_Descontador_Admin_View
     */
    private $admin_view;
    
    /**
     * Constructor
     */
    public function __construct() {
        $this->cliente_model = new Amelia_Descontador_Cliente();
        $this->paquete_model = new Amelia_Descontador_Paquete();
        $this->cita_model = new Amelia_Descontador_Cita();
        $this->admin_view = new Amelia_Descontador_Admin_View();
        
        // Inicializar hooks
        $this->init_hooks();
    }
    
    /**
     * Inicializar hooks de WordPress
     */
    private function init_hooks() {
        // Agregar menú de administración
        add_action('admin_menu', array($this, 'agregar_menu_admin'));
        
        // Registrar scripts y estilos
        add_action('admin_enqueue_scripts', array($this, 'registrar_assets'));
        
        // Registrar endpoints AJAX
        add_action('wp_ajax_buscar_clientes', array($this, 'ajax_buscar_clientes'));
        add_action('wp_ajax_cargar_paquetes', array($this, 'ajax_cargar_paquetes'));
        add_action('wp_ajax_obtener_citas_sin_paquete', array($this, 'ajax_obtener_citas_sin_paquete'));
        add_action('wp_ajax_asignar_cita_a_paquete', array($this, 'ajax_asignar_cita_a_paquete'));
    }
    
    /**
     * Agregar menú de administración
     */
    public function agregar_menu_admin() {
        // Opción 1: Como menú principal con icono personalizado
        add_menu_page(
            'Descontar Clases',
            'Descontar Clases',
            'manage_options',
            'amelia-descontador',
            array($this, 'render_admin_page'),
            'dashicons-calendar-alt', // Cambiado a un dashicon estándar
            30 // Posición en el menú
        );
        
        /* 
        // Opción 2: Como submenú de Amelia (comentado)
        add_submenu_page(
            'amelia',
            'Descontar Clases',
            'Descontar Clases',
            'manage_options',
            'amelia-descontador',
            array($this, 'render_admin_page')
        );
        */
    }
    
    /**
     * Registrar scripts y estilos
     */
    public function registrar_assets($hook) {
        // Verificar si estamos en la página del plugin
        // Ahora usamos 'toplevel_page_amelia-descontador' en lugar de 'amelia_page_amelia-descontador'
        if ($hook != 'toplevel_page_amelia-descontador') {
            return;
        }
        
        // Registrar estilos
        wp_enqueue_style(
            'amelia-descontador-admin',
            AMELIA_DESCONTADOR_PLUGIN_URL . 'includes/assets/css/amelia-descontador-admin.css',
            array(),
            AMELIA_DESCONTADOR_VERSION
        );
        
        // Registrar Select2
        wp_enqueue_style('select2', 'https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css');
        wp_enqueue_script('select2', 'https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js', array('jquery'), '4.1.0', true);
        
        // Registrar script principal
        wp_enqueue_script(
            'amelia-descontador-admin',
            AMELIA_DESCONTADOR_PLUGIN_URL . 'includes/assets/js/amelia-descontador-admin.js',
            array('jquery', 'select2'),
            AMELIA_DESCONTADOR_VERSION,
            true
        );
    }
    
    /**
     * Renderizar página de administración
     */
    public function render_admin_page() {
        $this->admin_view->render_admin_page();
    }
    
    /**
     * Endpoint AJAX para buscar clientes
     */
    public function ajax_buscar_clientes() {
        $term = isset($_REQUEST['term']) ? sanitize_text_field($_REQUEST['term']) : '';
        $clientes = $this->cliente_model->buscar_clientes($term);
        
        // Los resultados ya vienen en el formato correcto (id, text) desde el modelo
        // No necesitamos procesarlos, solo enviarlos
        wp_send_json($clientes);
    }
    
    /**
     * Endpoint AJAX para cargar paquetes de un cliente
     */
    public function ajax_cargar_paquetes() {
        $customer_id = isset($_POST['customerId']) ? intval($_POST['customerId']) : 0;
        
        if (!$customer_id) {
            wp_send_json_error('ID de cliente no válido');
        }
        
        $paquetes = $this->paquete_model->obtener_paquetes_activos($customer_id);
        
        ob_start();
        $this->admin_view->render_paquetes_activos($paquetes);
        $html = ob_get_clean();
        
        wp_send_json($html);
    }
    
    /**
     * Endpoint AJAX para obtener citas sin paquete
     */
    public function ajax_obtener_citas_sin_paquete() {
        $customer_id = isset($_POST['customerId']) ? intval($_POST['customerId']) : 0;
        $service_id = isset($_POST['serviceId']) ? intval($_POST['serviceId']) : 0;
        
        if (!$customer_id || !$service_id) {
            wp_send_json_error('Parámetros no válidos');
        }
        
        // Obtener datos
        $bookings = $this->cita_model->obtener_citas_sin_paquete($customer_id, $service_id);
        $cliente = $this->cliente_model->obtener_cliente($customer_id);
        $servicio = $this->cita_model->obtener_servicio($service_id);
        
        // Verificar que los datos existan
        if (!$cliente) {
            $cliente = new stdClass();
            $cliente->nombre = 'Cliente #' . $customer_id;
        }
        
        if (!$servicio) {
            $servicio = new stdClass();
            $servicio->name = 'Servicio #' . $service_id;
        }
        
        // Generar HTML
        $html = $this->admin_view->render_citas_sin_paquete($bookings, $cliente, $servicio);
        
        wp_send_json_success($html);
    }
    
    /**
     * Endpoint AJAX para asignar cita a paquete
     */
    public function ajax_asignar_cita_a_paquete() {
        $appointment_id = isset($_POST['appointmentId']) ? intval($_POST['appointmentId']) : 0;
        $package_id = isset($_POST['packageId']) ? intval($_POST['packageId']) : 0;
        
        if (!$appointment_id || !$package_id) {
            wp_send_json_error('Parámetros no válidos');
        }
        
        $result = $this->cita_model->asignar_cita_a_paquete($appointment_id, $package_id);
        
        if ($result['success']) {
            wp_send_json_success($result['message']);
        } else {
            wp_send_json_error($result['message']);
        }
    }
} 