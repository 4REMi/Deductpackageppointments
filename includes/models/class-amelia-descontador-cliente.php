<?php
/**
 * Modelo para manejar los clientes
 */
class Amelia_Descontador_Cliente {
    
    /**
     * Buscar clientes por término de búsqueda
     */
    public function buscar_clientes($term) {
        global $wpdb;
        
        $clientes = $wpdb->get_results($wpdb->prepare(
            "SELECT id, CONCAT(firstName, ' ', lastName, ' (', email, ')') AS text 
             FROM {$wpdb->prefix}amelia_users 
             WHERE type = 'customer' 
             AND (firstName LIKE %s OR lastName LIKE %s OR email LIKE %s) 
             LIMIT 10",
            "%$term%", "%$term%", "%$term%"
        ));
        
        return $clientes;
    }
    
    /**
     * Obtener información de un cliente por ID
     */
    public function obtener_cliente($customerId) {
        global $wpdb;
        
        $cliente = $wpdb->get_row($wpdb->prepare(
            "SELECT CONCAT(firstName, ' ', lastName) as nombre 
             FROM {$wpdb->prefix}amelia_users 
             WHERE id = %d",
            $customerId
        ));
        
        return $cliente;
    }
} 