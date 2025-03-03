# Amelia Descontador

WordPress plugin that allows manual deduction of classes from Amelia Booking packages.

## Description

This plugin extends the functionality of [Amelia Booking](https://wpamelia.com/), allowing administrators to manually deduct sessions from customers' class packages. It is especially useful for yoga studios, pilates studios, gyms, and other businesses that offer class packages.

## Features

- Quick customer search by name or email
- View active packages for a customer
- Manually deduct sessions by assigning existing appointments to packages
- Intuitive and easy-to-use interface
- Complete integration with Amelia Booking

## Requirements

- WordPress 5.0 or higher
- PHP 7.2 or higher
- Amelia Booking plugin installed and activated

## Installation

1. Download the plugin ZIP file
2. Go to your WordPress admin panel > Plugins > Add New
3. Click on "Upload Plugin" and select the downloaded ZIP file
4. Activate the plugin through the 'Plugins' menu in WordPress

## Usage

1. Go to Amelia > Deduct Classes in the WordPress admin menu
2. Search for a customer by name or email
3. Select an active package and click "Deduct"
4. Select an appointment without an assigned package to link it to the package
5. Confirm the assignment

## Plugin Structure (MVC)

The plugin follows the Model-View-Controller (MVC) design pattern for better code organization and maintenance:

### Models

- `Amelia_Descontador_Cliente`: Manages customer-related operations
- `Amelia_Descontador_Paquete`: Manages package-related operations
- `Amelia_Descontador_Cita`: Manages appointment-related operations

### Views

- `Amelia_Descontador_Admin_View`: Handles the user interface presentation

### Controllers

- `Amelia_Descontador_Admin_Controller`: Connects models with views and handles business logic

## Support

If you have any questions or issues, please create an issue in the plugin repository.

## License

This plugin is licensed under the [GPL v2 or later](https://www.gnu.org/licenses/gpl-2.0.html).

## Credits

Developed by [Your Name](https://example.com)

## Changelog

### 1.0.0
- Initial plugin version
- MVC pattern implementation
- Basic functionality for manually deducting classes 