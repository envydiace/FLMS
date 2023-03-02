import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { AddClubResponse } from '../../models/add-club-response.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { ClubDetail } from '../../models/club-detail.model';
import { AddClub } from '../../models/club-detail.model';

@Injectable({
  providedIn: 'root'
})
export class ClubService {

  public club: Observable<AddClub>;
  public userid: number;


  constructor(
    private router: Router,
    private http: HttpClient

  ) {

  }

  addClub(club: AddClub) {
    return this.http.post(`${environment.apiUrl}/api/Club/CreateClub`, club)
  }



}
