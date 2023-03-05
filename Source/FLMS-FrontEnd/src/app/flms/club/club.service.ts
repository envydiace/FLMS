import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AddClub } from '../../models/club-detail.model';
import { token } from '../../models/token.model';



@Injectable({
  providedIn: 'root'
})
export class ClubService {
  private headers: HttpHeaders;
  token: token;

  constructor(
    private router: Router,
    private http: HttpClient

  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  }

  addClub(club: AddClub) {
    return this.http.post(`${environment.apiUrl}/api/Club/CreateClub`, club,{headers: this.headers} )
  }



}
