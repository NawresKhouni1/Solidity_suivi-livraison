// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeliveryTracking {
    struct Order {
        string orderId; // ID unique de la commande
        string trackNumber; // Numéro de suivi
        string status; // Statut de la commande (ex: "En cours")
        address originAddress; // Adresse d'origine
        address destinationAddress; // Adresse de destination
        address currentLocation; // Adresse de localisation actuelle
        uint256 departureDate; // Date de départ
        uint256 arrivalDate; // Date prévue d'arrivée
        uint256 actualArrivalDate; // Date réelle d'arrivée
        uint256 timestamp; // Date de création
        int weight; // Poids
        int price; // Prix
    }

    // Mapping pour stocker les commandes
    mapping(string => Order) private orders;

    // Événements pour suivre les modifications
    event OrderCreated(
        string orderId,
        string trackNumber,
        string status,
        uint256 timestamp
    );
    event OrderUpdated(
        string orderId,
        string status,
        uint256 timestamp
    );

    // Fonction pour créer une commande
    function createOrder(
        string memory orderId,
        string memory trackNumber,
        string memory status,
        address originAddress,
        address destinationAddress,
        address currentLocation,
        uint256 departureDate,
        uint256 arrivalDate,
        int weight,
        int price
    ) public {
        require(bytes(orders[orderId].orderId).length == 0, "Commande existante");

        orders[orderId] = Order(
            orderId,
            trackNumber,
            status,
            originAddress,
            destinationAddress,
            currentLocation,
            departureDate,
            arrivalDate,
            0, // actualArrivalDate non défini au départ
            block.timestamp,
            weight,
            price
        );

        emit OrderCreated(orderId, trackNumber, status, block.timestamp);
    }

    // Fonction pour mettre à jour le statut de la commande
    function updateOrderStatus(
        string memory orderId,
        string memory status
    ) public {
        require(bytes(orders[orderId].orderId).length != 0, "Commande inexistante");

        orders[orderId].status = status;
        orders[orderId].timestamp = block.timestamp;

        emit OrderUpdated(orderId, status, block.timestamp);
    }

    // Fonction pour récupérer une commande
    function getOrder(
        string memory orderId
    ) public view returns (
        string memory,
        string memory,
        string memory,
        address,
        address,
        address,
        uint256,
        uint256,
        uint256,
        uint256,
        int,
        int
    ) {
        Order memory order = orders[orderId];
        require(bytes(order.orderId).length != 0, "Commande inexistante");

        return (
            order.orderId,
            order.trackNumber,
            order.status,
            order.originAddress,
            order.destinationAddress,
            order.currentLocation,
            order.departureDate,
            order.arrivalDate,
            order.actualArrivalDate,
            order.timestamp,
            order.weight,
            order.price
        );
    }
}
