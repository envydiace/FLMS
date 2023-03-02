import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ClubList } from './../../models/club-list.model';
import { Player } from 'src/app/models/player.model';
import { ClubDetailResponse } from './../../models/club-detail-response.model'

export interface token {
  accessToken: string,
  refreshToken: string,
  role: string
}

@Injectable({
  providedIn: 'root'
})
export class ClubService {
  private headers: HttpHeaders;
  token: token;

  constructor(
    private http: HttpClient
  ) { 
    this.token = JSON.parse(localStorage.getItem('user'));
    this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  }

  findAll(page: number, size: number): Observable<ClubList> {
    let params = new HttpParams();

    params = params.append('page', String(page));
    params = params.append('pageSize', String(size));

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubFilter`, { params }).pipe(
      map((clubList: ClubList) => clubList),
      catchError(err => throwError(err))
    )
  }

  public getListClubFilter(
    clubName: string,
    managerName: string,
    page: number,
    size: number
  ): Observable<any> {
    let params = new HttpParams();

    params = params.append('searchClubName', clubName);
    params = params.append('searchManagerName', managerName);
    params = params.append('page', String(page));
    params = params.append('pageSize', String(size));

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubFilter`, { params });
  }


  getdetailinfo(id: number): Observable<ClubDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetClub/${id}`).pipe(
      map((res: ClubDetailResponse) => res),
      catchError(err => throwError(err))
    )
  }

  public addPlayer(player: Player) {
    return this.http.post(`${environment.apiUrl}/api/Player/CreatePlayer`, player, {headers: this.headers});
  }

}



