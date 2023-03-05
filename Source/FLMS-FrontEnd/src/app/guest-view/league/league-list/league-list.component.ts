import { Component, OnInit } from '@angular/core';
import { LeagueDetailComponent } from '../league-detail/league-detail.component';
import { LeagueService } from './../league.service';
import { map, tap } from 'rxjs/operators';
import { LeagueDetail } from 'src/app/models/league-detail.model';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueList } from 'src/app/models/league-list.model';

@Component({
  selector: 'app-league-list',
  templateUrl: './league-list.component.html',
  styleUrls: ['./league-list.component.scss']
})
export class LeagueListComponent implements OnInit {

 leagueList: LeagueDetail[] =[] ;
  constructor(
    private leagueService: LeagueService
  ) { }


  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource(){
    this.leagueService.getLeagueList().pipe( map((leagueList: LeagueList) => this.leagueList = leagueList.leagues)
    ).subscribe();
  }


}


