import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { token } from './../../models/token.model';
import { Router } from '@angular/router';
import { MatchDetailResponse } from '../../models/match-detail-response.model';
import { MatchDetail } from '../../models/match-detail.model';
import { MatchStats } from '../../models/match-statistics-model'
import { MatchStatisticsResponse } from './../../models/match-statistic-response-model'
import { MatchEvent } from './../../models/match-event-detail.model';
import { Player } from 'src/app/models/player.model';
import { PlayerForEvent } from './../../models/player-for-event.model'

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
        catchError(err => throwError(err)))
  }

  getMatchStatsById(
    matchId: number
  ): Observable<MatchStatisticsResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/MatchStatistic/GetMatchStat/${matchId}`)
      .pipe(map((res: MatchStatisticsResponse) => res),
        catchError(err => throwError(err)))
  }


  getMatchEvent(matchId: number): Observable<MatchEvent[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Event/GetMatchEvent/${matchId}`,).pipe(
      map((res: MatchEvent[]) => res),
      catchError(err => throwError(err))
    )
  }

  updateMatchStats(body: MatchStatisticsResponse) {
    return this.http.put(`${environment.apiUrl}/api/MatchStatistic/UpdateMatchStat/`, body,{ headers: this.headers })
  }

  getPlayerForEvent(MatchId: number, EventType: string, ClubId: number): Observable<PlayerForEvent>{
    let params = new HttpParams();

    params = params.append("MatchId", String(MatchId))
    params = params.append("EventType", String(EventType))
    params = params.append("ClubId", String(ClubId))

    return this.http.get<any>(`${environment.apiUrl}/api/Squad/GetPlayerForEvent`, { params, headers: this.headers })
    .pipe(map((res: PlayerForEvent) => res),
      catchError(err => throwError(err)))
  }
}
