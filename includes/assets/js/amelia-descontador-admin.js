/**
 * JavaScript para la interfaz de administración del plugin Amelia Descontador
 */
(function($) {
    'use strict';

    /**
     * Inicializar el plugin cuando el DOM esté listo
     */
    $(document).ready(function() {
        // Inicializar Select2 para la búsqueda de clientes
        initClienteSelect();
        
        // Inicializar manejadores de eventos
        initEventHandlers();
    });

    /**
     * Inicializar Select2 para la búsqueda de clientes
     */
    function initClienteSelect() {
        $('#cliente_select').select2({
            placeholder: 'Buscar cliente por nombre o email',
            minimumInputLength: 2,
            ajax: {
                url: ajaxurl,
                dataType: 'json',
                delay: 250,
                data: function(params) {
                    return {
                        action: 'buscar_clientes',
                        term: params.term
                    };
                },
                processResults: function(data) {
                    return { results: data };
                },
                cache: true
            }
        }).on('select2:select', function(e) {
            let customerId = e.params.data.id;
            cargarPaquetesCliente(customerId);
        });
    }

    /**
     * Inicializar manejadores de eventos
     */
    function initEventHandlers() {
        // Manejar click en botón Descontar
        $(document).on('click', '.descontar', function() {
            var packageId = $(this).data('id');
            var $row = $(this).closest('tr');
            var serviceId = $row.data('service-id');
            var customerId = $('#cliente_select').val();
            
            obtenerCitasSinPaquete(customerId, serviceId, packageId, $row);
        });
        
        // Manejar click en botón Cancelar
        $(document).on('click', '.cancelar-descontar', function() {
            var $row = $(this).closest('tr');
            $('#citas_sin_paquete').remove();
            $row.find('.descontar').show();
            $row.find('.cancelar-descontar').hide();
        });

        // Manejar click en botón Asignar
        $(document).on('click', '.asignar', function() {
            var appointmentId = $(this).data('id');
            var packageId = $('#citas_sin_paquete').data('package-id');
            
            asignarCitaAPaquete(appointmentId, packageId);
        });
    }

    /**
     * Cargar paquetes activos de un cliente
     */
    function cargarPaquetesCliente(customerId) {
        $.post(ajaxurl, { 
            action: 'cargar_paquetes', 
            customerId: customerId 
        }, function(response) {
            $('#paquetes_activos').html(response);
        });
    }

    /**
     * Obtener citas sin paquete asignado
     */
    function obtenerCitasSinPaquete(customerId, serviceId, packageId, $row) {
        // Mostrar indicador de carga
        var $loadingIndicator = $('<div class="loading-indicator">Cargando...</div>');
        $('#paquetes_activos').after($loadingIndicator);
        
        $.post(ajaxurl, { 
            action: 'obtener_citas_sin_paquete', 
            customerId: customerId, 
            serviceId: serviceId 
        }, function(response) {
            // Eliminar indicador de carga
            $loadingIndicator.remove();
            
            if (response.success) {
                // Mostrar las citas sin paquete y ocultar el botón Descontar
                $('#citas_sin_paquete').remove(); // Eliminar tabla anterior si existe
                $('#paquetes_activos').after(response.data);
                $row.find('.descontar').hide();
                $row.find('.cancelar-descontar').show();
                
                // Guardar el ID del paquete seleccionado para usarlo en la asignación
                $('#citas_sin_paquete').data('package-id', packageId);
                
                // Asegurarse de que el mensaje sea visible
                if ($('#citas_sin_paquete .amelia-mensaje').length > 0) {
                    $('#citas_sin_paquete .amelia-mensaje').css({
                        'display': 'block',
                        'visibility': 'visible',
                        'opacity': '1'
                    });
                }
            } else {
                mostrarMensaje('error', response.data || 'Error al obtener las citas sin paquete.');
            }
        }).fail(function(xhr, status, error) {
            // Eliminar indicador de carga
            $loadingIndicator.remove();
            
            console.error("Error al obtener citas:", error);
            mostrarMensaje('error', 'Error al comunicarse con el servidor. Por favor, inténtelo de nuevo.');
        });
    }

    /**
     * Asignar una cita a un paquete
     */
    function asignarCitaAPaquete(appointmentId, packageId) {
        $.post(ajaxurl, { 
            action: 'asignar_cita_a_paquete', 
            appointmentId: appointmentId, 
            packageId: packageId 
        }, function(response) {
            if (response.success) {
                mostrarMensaje('success', response.data);
                
                // Recargar los paquetes para actualizar el conteo
                var customerId = $('#cliente_select').val();
                cargarPaquetesCliente(customerId);
                $('#citas_sin_paquete').remove();
            } else {
                mostrarMensaje('error', 'Error al asignar la cita: ' + response.data);
            }
        });
    }

    /**
     * Mostrar mensaje de notificación
     */
    function mostrarMensaje(tipo, mensaje) {
        var clase = tipo === 'success' ? 'amelia-mensaje-success' : 'amelia-mensaje-error';
        var $mensaje = $('<div class="amelia-mensaje ' + clase + '"><p>' + mensaje + '</p></div>');
        
        // Eliminar mensajes anteriores
        $('.amelia-descontador-container .amelia-mensaje').remove();
        
        // Agregar el nuevo mensaje al principio del contenedor
        $('.amelia-descontador-container').prepend($mensaje);
        
        // Añadir botón de cierre
        var $cerrar = $('<button type="button" class="cerrar-mensaje" style="position: absolute; top: 10px; right: 10px; background: none; border: none; cursor: pointer;">&times;</button>');
        $mensaje.css('position', 'relative').append($cerrar);
        
        $cerrar.on('click', function() {
            $(this).parent().fadeOut(300, function() { $(this).remove(); });
        });
        
        // Desplazarse al principio de la página
        $('html, body').animate({ scrollTop: 0 }, 'slow');
    }

})(jQuery); 