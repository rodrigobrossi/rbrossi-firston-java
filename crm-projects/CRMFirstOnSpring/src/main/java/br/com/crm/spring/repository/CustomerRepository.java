package br.com.crm.spring.repository;

import br.com.crm.spring.model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    // Basic CRUD operations are automatically implemented by Spring Data JPA
} 