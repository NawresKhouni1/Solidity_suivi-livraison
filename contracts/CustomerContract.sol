// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract CustomerContract {
    struct Customer {
        string id;
        string name;
        string addressInfo; // "address" est un mot-clé réservé
        string phone;
        string email;
    }

    mapping(string => Customer) private customers; // Stocker les clients par ID
    string[] private customerIds; // Liste des IDs pour faciliter l'itération

    // Ajouter un nouveau client
    function addCustomer(
        string memory _id,
        string memory _name,
        string memory _addressInfo,
        string memory _phone,
        string memory _email
    ) public {
        require(bytes(customers[_id].id).length == 0, "Customer ID already exists");
        customers[_id] = Customer(_id, _name, _addressInfo, _phone, _email);
        customerIds.push(_id);
    }

    // Récupérer les informations d'un client par ID
    function getCustomer(string memory _id) public view returns (Customer memory) {
        require(bytes(customers[_id].id).length > 0, "Customer not found");
        return customers[_id];
    }

    // Mettre à jour un client existant
    function updateCustomer(
        string memory _id,
        string memory _name,
        string memory _addressInfo,
        string memory _phone,
        string memory _email
    ) public {
        require(bytes(customers[_id].id).length > 0, "Customer not found");
        customers[_id] = Customer(_id, _name, _addressInfo, _phone, _email);
    }

    // Vérifier si un client existe
    function isCustomerExists(string memory _id) public view returns (bool) {
        return bytes(customers[_id].id).length > 0;
    }

    // Obtenir tous les IDs des clients
    function getAllCustomerIds() public view returns (string[] memory) {
        return customerIds;
    }
}
