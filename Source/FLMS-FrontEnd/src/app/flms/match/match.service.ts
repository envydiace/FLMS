import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { token } from './../../models/token.model';
import { Router } from '@angular/router';
import { MatchDetailResponse } from '../../models/match-detail-response.model';
import { EditMatchDetail, MatchDetail } from '../../models/match-detail.model';
import { MatchStats } from '../../models/match-statistics.model';
import { MatchStatisticsResponse } from '../../models/match-statistic-response.model';
import { AddMatchEvent, MatchEvent } from './../../models/match-event-detail.model';
import { Player } from 'src/app/models/player.model';
import { PlayerForEvent } from './../../models/player-for-event.model'
import { ClubListPlayerResponse } from 'src/app/models/club-list-player-response.model';
import { MatchSquad, UpdateSquad, ViewMatchSquad } from './../../models/match-squad.model';
import { getListPlayerJoinMatch } from 'src/app/models/club-list-player.model';

@Injectable({
  providedIn: 'root'
})
export class MatchService {

  private headers: HttpHeaders;
  token: token;
  constructor(
    private http: HttpClient,
    private router: Router
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    if (this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  getMatchInfoById(
    matchId: number
  ): Observable<MatchDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetMatchInfo/${matchId}`)
      .pipe(map((res: MatchDetailResponse) => res),
        catchError(err => throwError(err)));
  }

  getMatchStatsById(
    matchId: number
  ): Observable<MatchStatisticsResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/MatchStatistic/GetMatchStat/${matchId}`)
      .pipe(map((res: MatchStatisticsResponse) => res),
        catchError(err => throwError(err)));
  }


  getMatchEvent(matchId: number): Observable<MatchEvent[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Event/GetMatchEvent/${matchId}`,).pipe(
      map((res: MatchEvent[]) => res),
      catchError(err => throwError(err))
    );
  }

  updateMatchStats(body: MatchStatisticsResponse):Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/MatchStatistic/UpdateMatchStat/`, body, { headers: this.headers })
  }

  getMatchSquad(squadId: number): Observable<MatchSquad> {
    let params = new HttpParams();

    params = params.append("squadId", String(squadId));
    return this.http.get<any>(`${environment.apiUrl}/api/Squad/GetSquadByManager`, { params, headers: this.headers }).pipe(
      map((res: MatchSquad) => res)
    );
  }

  // editMatchInfo(body: MatchDetail):Observable<any> {
  //   return this.http.put(`${environment.apiUrl}/api/Match/UpdateMatch`, body, { headers: this.headers });

  // }
  editMatchInfo(body: EditMatchDetail):Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Match/UpdateMatch`, body, { headers: this.headers });

  }
  // getPlayerForEvent(ClubId: number): Observable<ClubListPlayerResponse> {
  //   let params = new HttpParams();

  //   params = params.append("ClubId", String(ClubId));

  //   return this.http.get<any>(`${environment.apiUrl}/api/Player/GetListPlayerByClubId`, { params, headers: this.headers })
  //     .pipe(map((res: ClubListPlayerResponse) => res),
  //       catchError(err => throwError(err)))
  // }

  getListPlayerJoinMatch(ClubId: number, matchId: number): Observable<getListPlayerJoinMatch[]> {
    let params = new HttpParams();

    params = params.append("ClubId", String(ClubId));
    params = params.append("MatchId", String(matchId));

    return this.http.get<any>(`${environment.apiUrl}/api/Squad/GetListPlayerJoinMatch`, { params, headers: this.headers })
      .pipe(map((res: getListPlayerJoinMatch[]) => res),
        catchError(err => throwError(err)))
  }

  removeEvent(matchId: number): Observable<any> {

    return this.http.delete(`${environment.apiUrl}/api/Event/DeleteMatchEvent/${matchId}`, { headers: this.headers });

  }

  addListEvent(events: AddMatchEvent[]): Observable<any> {
    return this.http.post(`${environment.apiUrl}/api/Event/AddMultipleMatchEvent`, events, { headers: this.headers });
  }

  updateSquad(squad: UpdateSquad): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Squad/UpdateSquadPosition`, squad, { headers: this.headers });
  }

  getMatchSquadByMatch(matchId: number): Observable<ViewMatchSquad> {
    return this.http.get<any>(`${environment.apiUrl}/api/Squad/GetMatchSquad/${matchId}`).pipe(
      map((res: ViewMatchSquad) => res)
    );
  }
}
