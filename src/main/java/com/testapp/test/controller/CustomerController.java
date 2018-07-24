package com.testapp.test.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.MediaType;
import com.testapp.test.model.Customer;
import com.testapp.test.repo.CustomerRepository;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin(origins = "http://0.0.0.0:8080")
@RestController
public class CustomerController {

    @Autowired
    CustomerRepository repository;

    
    @GetMapping(value = "/customer", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Customer> getAll() {
        List<Customer> list = new ArrayList<>();
        Iterable<Customer> customers = repository.findAll();

        customers.forEach(list::add);
        return list;
    }

    @PostMapping(value = "/postcustomer")
    public Customer postCustomer(@RequestBody Customer customer) {

        repository.save(new Customer(customer.getFirstName(), customer.getLastName()));
        return customer;
    }

    @GetMapping(value = "/findbylastname/{lastName}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Customer> findByLastName(@PathVariable String lastName) {

        List<Customer> customers = repository.findByLastName(lastName);
        return customers;
    }
    @DeleteMapping(value="/customer/{id}")
    public void deleteCustomer(@PathVariable long id){

        repository.deleteById(id);
    }
}