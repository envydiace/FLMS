import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { AddClub } from '../../models/club-detail.model';
import { token } from '../../models/token.model';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ClubList } from './../../models/club-list.model';
import { Player } from 'src/app/models/player.model';
import { ClubDetailResponse } from './../../models/club-detail-response.model';
import { ClubListbyUser } from 'src/app/models/club-detail.model';
import { ClubListPlayerResponse } from './../../models/club-list-player-response.model'
import { ClubMatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { ClubIncomingMatches } from 'src/app/models/club-incoming-matches-model';
import { ClubPlayerInfoResponse } from 'src/app/models/player-info-response.model';
import { ClubListPlayer } from 'src/app/models/club-list-player.model';
import { ClubLeagueHistory } from 'src/app/models/club-league-history.model';


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
    return this.http.post(`${environment.apiUrl}/api/Club/CreateClub`, club, { headers: this.headers });
  }


  findAll(page: number, size: number): Observable<ClubList> {
    let params = new HttpParams();

    params = params.append('page', String(page));
    params = params.append('pageSize', String(size));

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubFilter`, { params }).pipe(
      map((clubList: ClubList) => clubList),
      catchError(err => throwError(err))
    );
  }

  findbyUserId(): Observable<ClubListbyUser[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubByUser`, { headers: this.headers }).pipe(
      map((ClubListbyUser: ClubListbyUser[]) => ClubListbyUser),
      catchError(err => throwError(err))
    );
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
    );
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
    );
  }

  sendInvitation(leagueId: number, clubId: number) {
    let body = {
      leagueId,
      clubId
    }
    return this.http.post(`${environment.apiUrl}/api/Request/SendInvitation`, body, { headers: this.headers });
  }

  getClubMatch(clubId: number): Observable<ClubMatchScheduleResponse> {

    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetClubSchedule/${clubId}`).pipe(
      map((res: ClubMatchScheduleResponse) => res),
      catchError(err => throwError(err))
    );
  }

  getIncomingMatches(): Observable<ClubIncomingMatches[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetIncomingMatches`, { headers: this.headers }).pipe(
      map((res: ClubIncomingMatches[]) => res),
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
  removeEvent(playerId: number): Observable<any> {

    return this.http.delete(`${environment.apiUrl}/api/Player/DeletePlayer/${playerId}`, { headers: this.headers });

  }


  deleteClub(clubId: number): Observable<any>{
    return this.http.delete(`${environment.apiUrl}/api/Club/DeleteClub/${clubId}`, {headers: this.headers});
  }

  getClubLeagueHistory(clubId: number): Observable<ClubLeagueHistory[]> {

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetClubLeagueHistory/${clubId}`).pipe(
      map((res: ClubLeagueHistory[]) => res),
      catchError(err => throwError(err))
    );
  }

}
