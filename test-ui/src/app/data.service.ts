import { Injectable } from '@angular/core';
import { Headers, Http } from '@angular/http';


import { Customer } from './customer';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  private customersUrl = '172.31.46.255:8080/customer';  // URL to web API
  private headers = new Headers({'Content-Type': 'application/json'});

  constructor(private http: Http) {}

  // Get all customers
  getCustomers(): Promise<Customer[]> {

    return this.http.get(this.customersUrl)
      .toPromise()
      .then(response => response.json() as Customer[])
      .catch(this.handleError);
  }

  getCustomersByLastName(lastName: string): Promise<Customer[]> {
    const url = `http://172.31.46.255:8080/findbylastname/${lastName}`;
    return this.http.get(url)
      .toPromise()
      .then(response => response.json() as Customer)
      .catch(this.handleError);
  }

  create(customer: Customer): Promise<Customer> {
    return this.http
      .post('http://172.31.46.255:8080/postcustomer', JSON.stringify(customer), {headers : this.headers})
      .toPromise()
      .then(res => res.json() as Customer)
      .catch(this.handleError);
  }

  delete(id: number): Promise<void> {
    const url = `${this.customersUrl}/${id}`;
    return this.http.delete(url, {headers: this.headers})
      .toPromise()
      .then(() => null)
      .catch(this.handleError);
  }

  private handleError(error: any): Promise<any> {
    console.error('Error', error); // for demo purposes only
    return Promise.reject(error.message || error);
  }
}
