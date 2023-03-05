import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ClubList } from './../../models/club-list.model';
import { Player } from 'src/app/models/player.model';
import { ClubDetailResponse } from './../../models/club-detail-response.model'
import { token } from 'src/app/models/token.model';
import { ClubListPlayerResponse } from './../../models/club-list-player-response.model'

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
    if(this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
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
    return this.http.post(`${environment.apiUrl}/api/Player/CreatePlayer`, player, { headers: this.headers });
  }

  getPlayerListFilter(
    playerName: string,
    clubId: string
  ): Observable<ClubListPlayerResponse> {
    let params = new HttpParams();
    params = params.append('searchPlayerName', playerName);
    params = params.append('clubId', clubId);
    return this.http.get<any>(`${environment.apiUrl}/api/Player/GetListPlayerFilter`, { params }).pipe(
      map((res: ClubListPlayerResponse) => res),
      catchError(err => throwError(err))
    )
  }

  // sendInvitation(leagueId: number, clubId: number){
  //   let body = {
  //     leagueId,
  //     clubId
  //   }
  //   return this.http.post(`${environment.apiUrl}/api/Request/SendInvitation`, body,{headers: this.headers}  )
  // }


}



