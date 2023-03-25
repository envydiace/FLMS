import { Component, OnInit } from '@angular/core';
import { LeagueDetailComponent } from '../league-detail/league-detail.component';
import { LeagueService } from './../league.service';
import { map, tap } from 'rxjs/operators';
import { LeagueDetail } from 'src/app/models/league-detail.model';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { LeagueList } from 'src/app/models/league-list.model';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';

@Component({
  selector: 'app-league-list',
  templateUrl: './league-list.component.html',
  styleUrls: ['./league-list.component.scss']
})
export class LeagueListComponent implements OnInit {
  leagueName: string = null;
  leagueList: LeagueList = null;
  pageEvent: PageEvent;


  constructor(
    private leagueService: LeagueService,
    private router: Router
  ) { }


  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.getLeague();
  }

  getLeague() {
    this.leagueService.findAll(1, 8).pipe(
      map((leagueList: LeagueList) =>
        this.leagueList = leagueList
      ))
      .subscribe();
  }

  findLeagueByName(leagueName: string) {
    if (leagueName == null) leagueName = '';
    this.leagueService.findListLeagueFilter(leagueName, 1, 8).pipe(map((leagueList: LeagueList) => this.leagueList = leagueList)).subscribe();
  }

  onPaginateChange(event: PageEvent) {
    let page = event.pageIndex;
    let size = event.pageSize;
    if (this.leagueName == null) {
      page = page + 1;
      this.leagueService.findAll(page, size).pipe(map((leagueList: LeagueList) => this.leagueList = leagueList)).subscribe();
    } else {
      page = page + 1;
      if (this.leagueName == null) this.leagueName = '';
      this.leagueService.findListLeagueFilter(this.leagueName, page, size).pipe(map((leagueList: LeagueList) => this.leagueList = leagueList)).subscribe();
    }
  }

  navigateToLeagueDetail(id: number) {
    this.router.navigate(['/league-info'], { queryParams: { leagueId: id }});
  }
}


