package com.testapp.test.repo;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.testapp.test.model.Customer;

public interface CustomerRepository extends CrudRepository<Customer, Long> {
    List<Customer> findByLastName(String lastName);
}