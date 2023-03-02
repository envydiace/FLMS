import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { AddClubResponse } from '../../models/add-club-response.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { ClubDetail } from '../../models/club-detail.model';
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
