<?php
/**
 * Modelo para manejar los paquetes
 */
class Amelia_Descontador_Paquete {
    
    /**
     * Obtener paquetes activos de un cliente
     */
    public function obtener_paquetes_activos($customerId) {
        global $wpdb;
        
        $paquetes = $wpdb->get_results($wpdb->prepare(
            "SELECT pcs.id AS packageCustomerServiceId, p.name AS packageName, pcs.bookingsCount AS sesiones_totales,
                    COUNT(cb.id) AS sesiones_usadas, (pcs.bookingsCount - COUNT(cb.id)) AS sesiones_restantes,
                    s.name AS servicio, s.id AS serviceId, ptc.end AS expiration_date
             FROM {$wpdb->prefix}amelia_packages_customers_to_services pcs
             JOIN {$wpdb->prefix}amelia_packages_to_customers ptc ON pcs.packageCustomerId = ptc.id
             JOIN {$wpdb->prefix}amelia_packages p ON ptc.packageId = p.id
             JOIN {$wpdb->prefix}amelia_services s ON pcs.serviceId = s.id
             LEFT JOIN {$wpdb->prefix}amelia_customer_bookings cb ON pcs.id = cb.packageCustomerServiceId AND cb.status = 'approved'
             WHERE ptc.customerId = %d AND ptc.status = 'approved'
             GROUP BY pcs.id",
            $customerId
        ));
        
        return $paquetes;
    }
    
    /**
     * Verificar si un paquete tiene sesiones disponibles
     */
    public function verificar_disponibilidad($packageId) {
        global $wpdb;
        
        $paquete = $wpdb->get_row($wpdb->prepare(
            "SELECT pcs.bookingsCount AS sesiones_totales, COUNT(cb.id) AS sesiones_usadas
             FROM {$wpdb->prefix}amelia_packages_customers_to_services pcs
             LEFT JOIN {$wpdb->prefix}amelia_customer_bookings cb ON pcs.id = cb.packageCustomerServiceId AND cb.status = 'approved'
             WHERE pcs.id = %d
             GROUP BY pcs.id",
            $packageId
        ));
        
        if (!$paquete) {
            return [
                'success' => false,
                'message' => 'El paquete seleccionado no existe.'
            ];
        }
        
        if ($paquete->sesiones_usadas >= $paquete->sesiones_totales) {
            return [
                'success' => false,
                'message' => 'El paquete seleccionado no tiene sesiones disponibles.'
            ];
        }
        
        return [
            'success' => true,
            'paquete' => $paquete
        ];
    }
} 