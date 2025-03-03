<?php
/**
 * Modelo para manejar las citas
 */
class Amelia_Descontador_Cita {
    
    /**
     * Obtener citas sin paquete asignado
     */
    public function obtener_citas_sin_paquete($customerId, $serviceId) {
        global $wpdb;
        
        // Calcular la fecha límite (35 días atrás desde hoy)
        $fecha_limite = date('Y-m-d', strtotime('-35 days'));
        
        $bookings = $wpdb->get_results($wpdb->prepare(
            "SELECT cb.id, cb.created, a.bookingStart, a.bookingEnd, u.firstName, u.lastName, s.name as serviceName
             FROM {$wpdb->prefix}amelia_customer_bookings cb
             JOIN {$wpdb->prefix}amelia_appointments a ON cb.appointmentId = a.id
             JOIN {$wpdb->prefix}amelia_users u ON a.providerId = u.id
             JOIN {$wpdb->prefix}amelia_services s ON a.serviceId = s.id
             WHERE cb.customerId = %d 
             AND a.serviceId = %d 
             AND cb.packageCustomerServiceId IS NULL 
             AND cb.status = 'approved'
             AND DATE(a.bookingStart) >= %s
             AND DATE(a.bookingStart) <= CURDATE()
             ORDER BY a.bookingStart DESC
             LIMIT 20",
            $customerId, $serviceId, $fecha_limite
        ));
        
        return $bookings;
    }
    
    /**
     * Asignar una cita a un paquete
     */
    public function asignar_cita_a_paquete($bookingId, $packageId) {
        global $wpdb;
        
        // Eliminar los pagos asociados a esta reserva
        $wpdb->delete(
            "{$wpdb->prefix}amelia_payments",
            ['customerBookingId' => $bookingId],
            ['%d']
        );
        
        // Luego, actualizar la reserva para asignarla al paquete
        $result = $wpdb->update(
            "{$wpdb->prefix}amelia_customer_bookings",
            ['packageCustomerServiceId' => $packageId],
            ['id' => $bookingId],
            ['%d'],
            ['%d']
        );
        
        if ($result === false) {
            return [
                'success' => false,
                'message' => 'Error al actualizar la base de datos.'
            ];
        }
        
        return [
            'success' => true,
            'message' => 'Cita asignada correctamente al paquete y pago eliminado.'
        ];
    }
    
    /**
     * Crear una sesión artificial (para compatibilidad)
     */
    public function crear_sesion_artificial($packageCustomerServiceId) {
        global $wpdb;
        
        $result = $wpdb->insert(
            "{$wpdb->prefix}amelia_customer_bookings",
            [
                'packageCustomerServiceId' => $packageCustomerServiceId,
                'status' => 'approved',
                'created' => current_time('mysql')
            ],
            ['%d', '%s', '%s']
        );
        
        if ($result === false) {
            return [
                'success' => false,
                'message' => 'Error al crear la sesión artificial.'
            ];
        }
        
        return [
            'success' => true,
            'message' => 'Sesión descontada correctamente.'
        ];
    }
    
    /**
     * Obtener información de un servicio por ID
     */
    public function obtener_servicio($serviceId) {
        global $wpdb;
        
        $servicio = $wpdb->get_row($wpdb->prepare(
            "SELECT name FROM {$wpdb->prefix}amelia_services WHERE id = %d",
            $serviceId
        ));
        
        return $servicio;
    }
} 