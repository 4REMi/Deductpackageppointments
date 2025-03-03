<?php
/**
 * Vista para la interfaz de administración
 */
class Amelia_Descontador_Admin_View {
    
    /**
     * Renderizar el panel principal
     */
    public function render_admin_page() {
        ?>
        <div class="wrap amelia-descontador-container">
            <h1>Descontar Clases Manualmente</h1>
            <div class="cliente-selector">
                <label for="cliente_select">Buscar Cliente:</label>
                <select id="cliente_select" style="width: 300px;"></select>
            </div>
            <div id="paquetes_activos" class="paquetes-container"></div>
        </div>
        <?php
    }
    
    /**
     * Renderizar la tabla de paquetes activos
     */
    public function render_paquetes_activos($paquetes) {
        if (empty($paquetes)) {
            echo "<div class='notice notice-info'><p>No hay paquetes activos para este cliente.</p></div>";
            return;
        }
        
        echo "<h2>Paquetes Activos</h2><table class='wp-list-table widefat fixed striped'>
              <thead><tr>
                  <th>Paquete (Servicio)</th><th>Sesiones (Usadas/Totales)</th><th>Fecha de Expiración</th><th>Acción</th>
              </tr></thead><tbody>";
        foreach ($paquetes as $paquete) {
            echo "<tr data-service-id='{$paquete->serviceId}' data-package-id='{$paquete->packageCustomerServiceId}'>
                      <td>{$paquete->packageName} ({$paquete->servicio})</td>
                      <td>{$paquete->sesiones_usadas}/{$paquete->sesiones_totales}</td>
                      <td>" . date_i18n('j F Y', strtotime($paquete->expiration_date)) . "</td>
                      <td>
                          <button class='button button-primary descontar' data-id='{$paquete->packageCustomerServiceId}'>Descontar</button>
                          <button class='button cancelar-descontar' style='display:none;'>Cancelar</button>
                      </td>
                  </tr>";
        }
        echo "</tbody></table>";
    }
    
    /**
     * Renderizar la tabla de citas sin paquete
     */
    public function render_citas_sin_paquete($bookings, $cliente, $servicio) {
        ob_start();
        echo "<div id='citas_sin_paquete' class='citas-container'>";
        
        if (empty($bookings)) {
            // Asegurarse de que $cliente y $servicio existan y tengan las propiedades necesarias
            $nombre_cliente = isset($cliente->nombre) ? $cliente->nombre : 'Seleccionado';
            $nombre_servicio = isset($servicio->name) ? $servicio->name : 'Seleccionado';
            
            echo "<div class='amelia-mensaje amelia-mensaje-warning'>
                  <h3>No hay citas sin paquete asignado</h3>
                  <p>El cliente <strong>{$nombre_cliente}</strong> no tiene citas sin paquete para el servicio <strong>{$nombre_servicio}</strong> en los últimos 35 días.</p>
                  <p>Opciones disponibles:</p>
                  <ul style='list-style-type: disc; margin-left: 20px;'>
                      <li>Verificar si el cliente asistió a alguna clase que no fue registrada en el sistema.</li>
                      <li>Comprobar si la clase fue registrada con un servicio diferente.</li>
                      <li>Si necesita descontar una sesión manualmente, contacte al administrador del sistema.</li>
                  </ul>
                  </div>";
        } else {
            echo "<h3>Citas Sin Paquete Asignado (Últimos 35 días)</h3>";
            echo "<p>Seleccione una cita para asignarla al paquete y descontar una sesión:</p>";
            echo "<table class='wp-list-table widefat fixed striped'>
                  <thead><tr>
                      <th>Fecha</th><th>Hora</th><th>Servicio</th><th>Instructor</th><th>Acción</th>
                  </tr></thead><tbody>";
            foreach ($bookings as $booking) {
                // Convertir la hora a la zona horaria de WordPress
                $wp_date = get_date_from_gmt($booking->bookingStart);
                $fecha_formateada = date_i18n('j F Y', strtotime($wp_date));
                $hora_formateada = date_i18n('H:i', strtotime($wp_date));
                
                echo "<tr>
                          <td>{$fecha_formateada}</td>
                          <td>{$hora_formateada}</td>
                          <td>{$booking->serviceName}</td>
                          <td>{$booking->firstName} {$booking->lastName}</td>
                          <td><button class='button button-primary asignar' data-id='{$booking->id}'>Asignar</button></td>
                      </tr>";
            }
            echo "</tbody></table>";
        }
        
        echo "</div>";
        return ob_get_clean();
    }
} 