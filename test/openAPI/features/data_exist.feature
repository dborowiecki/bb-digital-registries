Feature: API endopont allowing users to check if a record exists in the Digital Registries database.
  Request endpoint: POST /data/{registryname}/{versionnumber}/exists

  Scenario: The user receives a message that the record exists in the Digital Registries database
    Given The user wants to check if a record with the first name "John Helmut" exists in the Digital Registries database
    And The record with the first name "John Helmut" is available in the database 
    When The user triggers an action to check if the record with the first name "John Helmut" already exists in the database
    Then Operation for "/data/{registryname}/{versionnumber}/exists" finishes successfully
    And The user receives an information that the record exists in the database

  Scenario: The user receives the message that the record does not exist in the Digital Registries database
    Given The user wants to check if a record with the first name "Adrien" exists in the Digital Registries database
    And The record with the first name "Adrien" is not available in the database 
    When The user triggers an action to check if the record with the first name "Adrien" exists in the database
    Then Operation for "/data/{registryname}/{versionnumber}/exists" finishes successfully
    And The user receives an information that the record does not exist in the database

  Scenario: The user is not able to check if the record exists in the Digital Registries database because of an invalid request
    Given The user wants to check if a record with the first name "Anna" exists in the Digital Registries database
    When The user triggers an action to check if the record with the first name "Anna" exists in the database
    Then Operation results for /data/registryname/versionnumber/exists is an error
