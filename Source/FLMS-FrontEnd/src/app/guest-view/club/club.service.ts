import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ClubList } from './../../models/club-list.model';
import { Player } from 'src/app/models/player.model';
import { ClubDetailResponse } from './../../models/club-detail-response.model'
import { token } from 'src/app/models/token.model';
import { ClubListbyUser } from 'src/app/models/club-detail.model';
import { ClubListPlayerResponse } from './../../models/club-list-player-response.model'
import { ClubMatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { ClubLeagueHistory } from './../../models/club-league-history.model';
import { ClubLeagueHistoryResponse } from './../../models/club-league-history-response.model'
import { ClubPlayerInfoResponse } from './../../models/player-info-response.model'
import { ClubListPlayer } from 'src/app/models/club-list-player.model';
import { ClubMatchHistoryResponse } from './../../models/club-match-history-response.model';

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
    if (this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
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

  findbyUserId(): Observable<ClubListbyUser[]> {

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubByUser`, { headers: this.headers }).pipe(
      map((ClubListbyUser: ClubListbyUser[]) => ClubListbyUser),
      catchError(err => throwError(err))
    )
  }

  public getListClubFilter(
    search: string,
    page: number,
    size: number
  ): Observable<any> {
    let params = new HttpParams();

    params = params.append('search', search);
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

  sendInvitation(leagueId: number, clubId: number): Observable<any> {
    let body = {
      leagueId,
      clubId
    }
    return this.http.post(`${environment.apiUrl}/api/Request/SendInvitation`, body, { headers: this.headers })
  }

  getClubMatch(clubId: number): Observable<ClubMatchScheduleResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetClubSchedule/${clubId}`).pipe(
      map((res: ClubMatchScheduleResponse) => res),
      catchError(err => throwError(err))
    )
  }
  getClubLeagueHistory(clubId: number): Observable<ClubLeagueHistory[]> {

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetClubLeagueHistory/${clubId}`).pipe(
      map((res: ClubLeagueHistory[]) => res),
      catchError(err => throwError(err))
    );
  }

  getClubMatchHistory(clubId: number): Observable<ClubMatchHistoryResponse> {

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetClubHistory/${clubId}`).pipe(
      map((res: ClubMatchHistoryResponse) => res),
      catchError(err => throwError(err))
    );
  }

  getPlayerInfo(playerId: number): Observable<ClubPlayerInfoResponse> {

    return this.http.get<any>(`${environment.apiUrl}/api/Player/GetPlayer/${playerId}`)
      .pipe(map((res: ClubPlayerInfoResponse) => res),
        catchError(err => throwError(err)))
  }

  editPlayer(player: ClubListPlayer) {
    return this.http.put(`${environment.apiUrl}/api/Player/UpdatePlayer`, player, { headers: this.headers });
  }

}



