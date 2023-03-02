import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { UserRegister } from '../../models/new-user-model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';


@Injectable({
  providedIn: 'root'
})
export class RegisterService {

  public user: Observable<UserRegister>;
  constructor(
    private router: Router,
    private http: HttpClient
  ) { }
  register(user: UserRegister) {
    return this.http.post(`http://localhost:5000/api/Signup`, user)
  }


}
